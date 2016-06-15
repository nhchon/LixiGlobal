/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model.pojo;

/**
 *
 * @author Asus
 */
public class LixiCheckStatusResult {
    
    private CheckStatusResult data;

    public CheckStatusResult getData() {
        return data;
    }

    public void setData(CheckStatusResult data) {
        this.data = data;
    }
    
    @Override
    public String toString(){
        return "["+data+"]";
    }
}
