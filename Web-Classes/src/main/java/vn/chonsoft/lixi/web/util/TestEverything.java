/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.util;

import java.util.Arrays;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author chonnh
 */
public class TestEverything {
    
    public static final String MU = "Manchester United";
    
    public static void thangHoaThua(int f, int s, int[] r){
        int no = f > s ? r[0]++ : (f == s ? r[1]++ : r[2]++);
    }
    
    public static void main(String[] args) {
        
        System.out.println(Math.floor(21766.8/100)*100);
        /*
        String result = "Manchester United 1 Chelsea 0, Manchester United 2 Liverpool 0, Manchester United 1 Totemham 1, Asernal 4 Manchester United 2";
        String[] arrs = result.split(",");
        // [Thang, Hoa, Thua]
        int[] muResult = {0, 0, 0};
        for (String m  : arrs) {
            Pattern pattern = Pattern.compile("\\d+");
            String[] players = pattern.split(m);
            Matcher matcher = pattern.matcher(m);
            // Get scores
            matcher.find(); int firstScore = Integer.parseInt(matcher.group());
            matcher.find(); int secondScore = Integer.parseInt(matcher.group());
            if(MU.equals(players[0].trim())){
                thangHoaThua(firstScore, secondScore, muResult);
            }
            if(MU.equals(players[1].trim())){
                thangHoaThua(secondScore, firstScore, muResult);
            }
        }
        System.out.println(Arrays.toString(muResult));
                */
        //Book b = new Book();
        //b.setTitle("ABC");
        //b.setAuthor("XYZ");
        //System.out.println(LiXiUtils.marshal(b));
        //System.out.println(String.valueOf(18.99));
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
