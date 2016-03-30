/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model.pojo;

/**
 *
 * @author chonnh
 */
public class VatGiaProductPj {
    
    private Integer id;
    private Integer category_id;
    private String category_name;
    private String name;
    private Double price;
    private String image_url;
    private String image_full_size;
    private String link_detail;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCategory_id() {
        return category_id;
    }

    public void setCategory_id(Integer category_id) {
        this.category_id = category_id;
    }

    public String getCategory_name() {
        return category_name;
    }

    public void setCategory_name(String category_name) {
        this.category_name = category_name;
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

    public String getImage_full_size() {
        return image_full_size;
    }

    public void setImage_full_size(String image_full_size) {
        this.image_full_size = image_full_size;
    }

    public String getLink_detail() {
        return link_detail;
    }

    public void setLink_detail(String link_detail) {
        this.link_detail = link_detail;
    }
    
    @Override
    public String toString(){
        return "[" +id + ", " + category_id + ", " + category_name +  ", " + name + ", " + price + ", " + image_url+ ", " + link_detail  + "]";
    }
}
