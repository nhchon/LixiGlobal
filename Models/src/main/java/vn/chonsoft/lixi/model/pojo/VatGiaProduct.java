/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model.pojo;

/**
 *
 * @author chonnh
 */
public class VatGiaProduct {
    
    private Integer id;
    private String category;
    private String name;
    private Double price;
    private String image_url;
    private String link_detail;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getImage_url() {
        return image_url;
    }

    public void setImage_url(String image_url) {
        this.image_url = image_url;
    }

    public String getLink_detail() {
        return link_detail;
    }

    public void setLink_detail(String link_detail) {
        this.link_detail = link_detail;
    }
    
    @Override
    public String toString(){
        return "[" +id + ", " + category +  ", " + name + ", " + price + ", " + image_url+ ", " + link_detail  + "]";
    }
}
