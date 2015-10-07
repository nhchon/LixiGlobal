/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.util;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;
import org.apache.commons.lang3.StringUtils;

/**
 *
 * @author chonnh
 */
public class TestEverything {

    public static void main(String[] args) {
        
        Book b = new Book();
        b.setTitle("ABC");
        b.setAuthor("XYZ");
        
        System.out.println(LiXiUtils.marshal(b));
//        Queue<String> input = new LinkedList(Arrays.asList("a11", "b22", "c33", "d44", "e55"));
//        Queue<String> output = new LinkedList(Arrays.asList("a11", "c33", "d44", "b22", "e55"));
//        List<String> checkedList = new ArrayList<>();
//        List<String> viPham = new ArrayList<>();
//        
//        for(;!output.isEmpty();){
//            
//            String o = output.poll();
//            String i = input.poll();
//            if(checkedList.contains(o)){
//                // ignore
//            }else{
//                if(!o.equals(i)){
//                    viPham.add(o);
//                }
//            }
//            // add to cheked list
//            checkedList.add(i);
//        }
//        viPham.forEach(x -> System.out.println(x));

        //TestEverything e = new TestEverything();
        //e.testBigDecimal(new BigDecimal("800000"), new BigDecimal("20500.0"));
        //e.testBigDecimal(new BigDecimal("1600000"), new BigDecimal("20500.0"));
//        double a = 39.0244 + 0.005;
//        double b = 78.0488 + 0.005*2;
//        
//        double roundOff = Math.round(a * 100.0) / 100.0;
//        
//        DecimalFormat df = new DecimalFormat("###,###.##");
//        //System.out.println(roundOff);
//        //System.out.println(df.format(a));
//        //System.out.println(df.format(b));
//        
//        double rsl = ((700000 * 1) / 20500.0) + (1 * 0.005);
//        
//        //System.out.println(Math.round(rsl * 100.0) / 100.0);
//        
//        double rsl1 = ((700000 * -1) / 20500.0) + (-1 * 0.005);
//        
//        //System.out.println(Math.round(rsl1 * 100.0) / 100.0);
//        
//        //System.out.println((long)rsl1);
//        //System.out.println(StringUtils.leftPad("123456789", 6, '0'));
//        
//        //System.out.println("1|LG036739|8995760|190440|iWawDEMAtCiEwAt3EWXprcIZON+qmuGK9IXGFwJCma/5K99i9mWpObodPWF4XXzt5N2/S2y7VKCNtD8k0qc68WXqmDehYI29wAhkiW4ipeqytMbR".split("\\|").length);
//        //System.out.println("1|LG036739||190440".split("\\|").length);
//        
//        System.out.println(StringUtils.substring("0967007869", 0, 3));
//        System.out.println(StringUtils.substring("0967007869", 0, 4));
        
    }
}
