/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.chonsoft.lixi.repositories.service.util;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.nodes.TextNode;
import org.jsoup.select.Elements;
import vn.chonsoft.lixi.model.fido.FidoDogPark;

/**
 *
 * @author chonnh
 */
public class FidoUtils {

    private static final Logger log = LogManager.getLogger();
    //
    public static final boolean USE_PROXY = false;
    public static final String PROXY_SERVER = "https://mycreate-proxy.appspot.com";

    public static String handleUrl(String url) {
        if (url == null || "".equals(url)) {
            return url;
        }
        //
        String urlTemp = url;
        if (urlTemp.startsWith("http://") || urlTemp.startsWith("https://")) {
            if (USE_PROXY) {
                urlTemp = urlTemp.replaceAll("https://", "");
                urlTemp = urlTemp.replaceAll("http://", "");
                //
                urlTemp = PROXY_SERVER + urlTemp;
            }
        } else {
            if (url.startsWith("/")) {
                url = url.substring(1);
            }
            urlTemp = "http://" + url;
        }

        log.info(url + " : " + urlTemp);
        return urlTemp;
    }

    /**
     *
     * @param cityUrl
     * @return
     */
    public static List<String> getDogParkPages(String cityUrl) {
        try {
            if (cityUrl == null || "".equals(cityUrl)) {
                return new ArrayList<>();
            }
            //
            String url = handleUrl(cityUrl);
            //
            Document doc = Jsoup.connect(url)
                    .userAgent("Mozilla")
                    .get();
            //
            Elements mydesiredElems = doc.select("div#results_paging_controls_bottom");
            Elements pages = mydesiredElems.select("a[href]");

            List<String> pl = new ArrayList<>();
            for (Element page : pages) {
                pl.add(page.attr("abs:href"));
            }
            // remove next element
            if (pl.size() > 1) {
                pl.remove(pl.size() - 1);
            }
            //
            return pl;
        } catch (Exception e) {
            log.info(e.getMessage(), e);
        }
        return new ArrayList<>();
    }

    /**
     * 
     * @param cityUrl
     * @return 
     */
    public static List<FidoDogPark> getDogParks(String cityUrl) {
        try {
            if (cityUrl == null || "".equals(cityUrl)) {
                return new ArrayList<>();
            }
            //
            String url = handleUrl(cityUrl);
            log.info("getDogParks: " + url);
            //
            Document doc = Jsoup.connect(url)
                    .userAgent("Mozilla")
                    .get();
            //
            Elements mydesiredElems = doc.select("div#results_list");
            Elements objectSnapshot = mydesiredElems.select("div.object_snapshot");

            List<FidoDogPark> l = new ArrayList<>();
            for (Element snapShot : objectSnapshot) {

                FidoDogPark fdp = new FidoDogPark();
                //
                Element photo = snapShot.select("div.photo").first();
                Element info = snapShot.select("div.info").first();
                //
                Element img = photo.select("img[src]").first();
                fdp.setPhotoUrl(img.attr("abs:src"));
                //
                Element detailUrl = info.select("h1 > a[href]").first();
                fdp.setParkName(detailUrl.text());
                fdp.setAddressDetailUrl(detailUrl.attr("abs:href"));
                //
                int i = 0;
                for (TextNode tn : info.textNodes()) {
                    String text = tn.text();
                    if (text != null && !"".equals(text.trim())) {
                        fdp.setDescription(tn.text());
                        break;
                    }
                }
                fdp.setCreatedDate(Calendar.getInstance().getTime());
                //
                l.add(fdp);
            }
            return l;
        } catch (Exception e) {
            log.info(e.getMessage(), e);
        }
        return new ArrayList<>();
    }

    /**
     * 
     * @param detailUrl
     * @return 
     */
    public static List<String> getDetailDogParkAddress(String detailUrl) {
        try {
            if (detailUrl == null || "".equals(detailUrl)) {
                return new ArrayList<>();
            }
            //
            String url = handleUrl(detailUrl);
            //
            Document doc = Jsoup.connect(url)
                    .userAgent("Mozilla")
                    .get();
            //
            Element mydesiredElems = doc.select("div#detail_header").first();
            Element address = mydesiredElems.select("div.address").first();
            //
            List<String> al = new ArrayList<>();
            for (TextNode tn : address.textNodes()) {
                String text = tn.text();
                if (text != null && !"".equals(text.trim())) {
                    al.add(tn.text());
                }
            }
            //
            return al;
        } catch (Exception e) {
            log.info(e.getMessage(), e);
        }
        
        return new ArrayList<>();
    }
    
}
