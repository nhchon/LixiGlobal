/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.util;

import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBElement;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.namespace.QName;
import org.apache.commons.lang3.StringUtils;
import vn.chonsoft.lixi.LiXiGlobalConstants;

/**
 *
 * @author chonnh
 */
public abstract class LiXiGlobalUtils {
    
    /**
     *
     * @param object
     * @return
     */
    public static <T> String marshal(T object) {
        try {
            StringWriter stringWriter = new StringWriter();
            JAXBContext context = JAXBContext.newInstance(object.getClass());
            Marshaller marshaller = context.createMarshaller();
            marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);
            marshaller.marshal(object, stringWriter);
            //marshaller.marshal( new JAXBElement(new QName("uri","local"), object.getClass(), object ), stringWriter);
            return stringWriter.toString();
        } catch (JAXBException e) {
            //
            //log.info(e.getMessage(), e);
            //
            return (String.format("Exception while marshalling: %s", e.getMessage()));
        }
    }

    /**
     * 
     * @param <T>
     * @param object
     * @return 
     */
    public static <T> String marshalWithoutRootElement(T object) {
        try {
            StringWriter stringWriter = new StringWriter();
            JAXBContext context = JAXBContext.newInstance(object.getClass());
            Marshaller marshaller = context.createMarshaller();
            marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);
            //marshaller.marshal(object, stringWriter);
            marshaller.marshal( new JAXBElement(new QName("uri","local"), object.getClass(), object ), stringWriter);
            return stringWriter.toString();
        } catch (JAXBException e) {
            //
            //log.info(e.getMessage(), e);
            //
            return (String.format("Exception while marshalling: %s", e.getMessage()));
        }
    }
    
    /**
     * 
     * @param <E>
     * @param i
     * @return 
     */
    public static <E> List<E> toList(Iterable<E> i)
    {
        List<E> list = new ArrayList<>();
        i.forEach(list::add);
        return list;
    }
    
    /**
     * 
     * @param rId
     * @return 
     */
    public static String getBeautyRId(Long rId){
        
        if(rId == null) return "";
        
        String r = rId.toString();
        
        r = StringUtils.leftPad(r, 8, "0");
        
        StringBuilder br = new StringBuilder();
        
        br.append(LiXiGlobalConstants.R);
        br.append(r);
        
        br.insert(4, '-');
        br.insert(7, '-');
        
        return br.toString();
    }
    
    /**
     * 
     * @param rId
     * @return 
     */
    public static String getBeautySId(Long rId){
        
        if(rId == null) return "";
        
        String r = rId.toString();
        
        r = StringUtils.leftPad(r, 8, "0");
        
        StringBuilder br = new StringBuilder();
        
        br.append(LiXiGlobalConstants.S);
        br.append(r);
        
        br.insert(4, '-');
        br.insert(7, '-');
        
        return br.toString();
    }
}
