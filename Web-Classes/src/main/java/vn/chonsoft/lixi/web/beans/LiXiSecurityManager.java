/**
 * <p>
 * Title: RSA Security</p>
 * Description: This class generates a RSA private and public key,
 * reinstantiates the keys from the corresponding key files.It also generates
 * compatible .Net Public Key, which we will read later in C# program using .Net
 * Securtiy Framework The reinstantiated keys are used to sign and verify the
 * given data.</p>
 *
 * @author Shaheryar
 * @version 1.0
 */
package vn.chonsoft.lixi.web.beans;

import java.security.*;
import java.security.spec.*;
import org.apache.commons.codec.binary.*;

public class LiXiSecurityManager {

    private PrivateKey privateKey; // Private Key Class
    private PublicKey publicKey; // Public Key Class
    private Signature sign; // Signature, used to sign the data
    //
    private byte[] privateKeyBytes;
    private byte[] publicKeyBytes;

    /**
     * Default Constructor. Instantiates the key paths and signature algorithm.
     */
    public LiXiSecurityManager() {
        try {

            //Get the instance of Signature Engine.
            sign = Signature.getInstance("SHA1withRSA");
        } catch (NoSuchAlgorithmException nsa) {
            System.out.println("" + nsa.getMessage());
        }
    }

    public void setPrivateKeyBytes(byte[] privateKeyBytes) {
        this.privateKeyBytes = privateKeyBytes;
    }

    public void setPublicKeyBytes(byte[] publicKeyBytes) {
        this.publicKeyBytes = publicKeyBytes;
    }

    /**
     * Initializes the public and private keys.
     */
    public void initializeKeys() {
        try {
            //Read key files back and decode them from BASE64
            //BASE64Decoder decoder = new BASE64Decoder();
            byte[] privateKeyBytes = Base64.decodeBase64(this.privateKeyBytes);
            byte[] publicKeyBytes = Base64.decodeBase64(this.publicKeyBytes);

            // Convert back to public and private key objects
            KeyFactory keyFactory = KeyFactory.getInstance("RSA");
            EncodedKeySpec privateKeySpec = new PKCS8EncodedKeySpec(privateKeyBytes);
            privateKey = keyFactory.generatePrivate(privateKeySpec);

            EncodedKeySpec publicKeySpec = new X509EncodedKeySpec(publicKeyBytes);
            publicKey = keyFactory.generatePublic(publicKeySpec);

        } catch (InvalidKeySpecException e) {
            System.out.println(
                    "Invalid Key Specs. Not valid Key files." + e.getCause());
        } catch (NoSuchAlgorithmException e) {
            System.out.println(
                    "There is no such algorithm. Please check the JDK ver." + e.getCause());
        }
    }

    /**
     * Signs the data and return the signature for a given data.
     *
     * @param toBeSigned Data to be signed
     * @return byte[] Signature
     */
    public byte[] signData(byte[] toBeSigned) {
        
        if (privateKey == null) {
            initializeKeys();
        }

        try {
            Signature rsa = Signature.getInstance("SHA1withRSA");
            rsa.initSign(privateKey);
            rsa.update(toBeSigned);
            return rsa.sign();
        } catch (NoSuchAlgorithmException ex) {
            System.out.println(ex);
        } catch (InvalidKeyException in) {
            System.out.println(
                    "Invalid Key file.Please check the key file path" + in.getCause());
        } catch (SignatureException se) {
            System.out.println(se);
        }
        return null;
    }

    /**
     * Verifies the signature for the given bytes using the public key.
     *
     * @param signature Signature
     * @param data Data that was signed
     * @return boolean True if valid signature else false
     */
    public boolean verifySignature(byte[] signature, byte[] data) {
        try {
            //initializeKeys();
            sign.initVerify(publicKey);
            sign.update(data);
            return sign.verify(signature);
        } catch (SignatureException e) {
            e.printStackTrace();
        } catch (InvalidKeyException e) {
        }

        return false;
    }

  //public static void main(String args[])
    //{
    //  LiXiSecurityManager sm = new LiXiSecurityManager();

    /*
     Uncomment next line for first time when you run the code,it will generate the keys.
     Afterwards,the application will read the generated key files from the given location.
     If you want to generate the key files each time, then you should keep it uncommented always.

     Note: Location of key files have been hardocded i.e. c:\\public.rsa... etc
     You can change the location to what ever you want.

     */
    //sm.generateKeys(1024);
//    String dataToBesigned = "This data will be signed .... you can provide any data here.";
//    byte[] signature = sm.signData(dataToBesigned.getBytes());
//
//    BASE64Encoder encoder = new BASE64Encoder();
//    String signedB64 = encoder.encode(signature);// You may store this signature in a text file.
//    String dataB64 = encoder.encode(dataToBesigned.getBytes());// You may store the data as well in a text file.
//
//    //writing data to file, which will be read later by C# program for verification
//    sm.writeBytesToFile(dataB64.getBytes(),"/home/chonnh/Documents/VTC/data.dat");
//    //writing signature to file, which will be read later by C# program for verification
//    sm.writeBytesToFile(signedB64.getBytes(),"/home/chonnh/Documents/VTC/signature.dat");
//
//    System.out.println("Signature: \n"+signedB64 + "\n\n\n\n" + "Data that was signed : \n"+dataB64);
//    System.out.println("Verifying the data using Public Key:\n Data is Verified : "+sm.verifySignature(signature,dataToBesigned.getBytes()));
//  }
}
