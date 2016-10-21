/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model.form;

import vn.chonsoft.lixi.validations.NotBlank;

/**
 *
 * @author Asus
 */
public class InputProductForm {
    
    private Integer id = 0;
    
    @NotBlank(message = "{validate.not_null}")
    private String name;
    
    private Integer category;
    
    private Integer price;
    
    @NotBlank(message = "{validate.not_null}")
    private String imageUrl;
    
    @NotBlank(message = "{validate.not_null}")
    private String description;
    
    @NotBlank(message = "{validate.not_null}")
    private String productSource;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getCategory() {
        return category;
    }

    public void setCategory(Integer category) {
        this.category = category;
    }

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getProductSource() {
        return productSource;
    }

    public void setProductSource(String productSource) {
        this.productSource = productSource;
    }
    
    
}
