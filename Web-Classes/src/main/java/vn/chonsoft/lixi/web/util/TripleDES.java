/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.util;

import java.math.BigInteger;
import java.security.MessageDigest;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import org.apache.commons.codec.binary.Base64;

/**
 *
 * @author chonnh
 */
public class TripleDES {
    
    /* key */
    private String key;
    
    public TripleDES(){
    }

    /**
     * 
     * @param key 
     */
    public void setKey(String key) {
        this.key = key;
    }
    
    
    /**
     * 
     * @param data
     * @return
     * @throws Exception 
     */
    public String encrypt(String data) throws Exception {
        Cipher cipher = Cipher.getInstance("TripleDES");
        MessageDigest md5 = MessageDigest.getInstance("MD5");
        md5.update(key.getBytes(), 0, key.length());
        String keymd5 = new BigInteger(1, md5.digest()).toString(16).substring(0,
                24);
        SecretKeySpec keyspec = new SecretKeySpec(keymd5.getBytes(), "TripleDES");
        cipher.init(Cipher.ENCRYPT_MODE, keyspec);
        byte[] stringBytes = data.getBytes();
        byte[] raw = cipher.doFinal(stringBytes);
        String base64 = Base64.encodeBase64String(raw);
        return base64;
    }

    /**
     * 
     * @param data
     * @return
     * @throws Exception 
     */
    public String decrypt(String data) throws Exception {
        
        Cipher cipher = Cipher.getInstance("TripleDES");
        
        MessageDigest md5 = MessageDigest.getInstance("MD5");
        md5.update(key.getBytes(), 0, key.length());
        
        String keymd5 = new BigInteger(1, md5.digest()).toString(16).substring(0, 24);
        
        SecretKeySpec keyspec = new SecretKeySpec(keymd5.getBytes(), "TripleDES");
        
        cipher.init(Cipher.DECRYPT_MODE, keyspec);
        
        byte[] raw = Base64.decodeBase64(data);
        
        byte[] stringBytes = cipher.doFinal(raw);
        
        String result = new String(stringBytes);
        return result;
    }
    
    ////////////////////////////////////////////////////////////////////////////
    /*
    public static void main(String[] args) throws Exception{
    
        String data = "Hello baby !";
        
        String encrypted = encrypt(KEY, data);
                
        System.out.println(encrypted);
        //
        String decryoted = decrypt(KEY, "tgYioMevnEo0eCQnCUq69vKCwKsKYXjx4rpr38vohMfbRVly+vf7X7veuaXOMSOg");
        
        System.out.println(decryoted);
    }
    */
}
