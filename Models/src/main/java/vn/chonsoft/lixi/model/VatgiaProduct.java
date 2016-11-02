/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.model;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import org.jsoup.Jsoup;

/**
 *
 * @author chonnh
 */
@Entity
@Table(name = "vatgia_products")
public class VatgiaProduct implements Serializable {
    
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    
    @Basic(optional = false)
    @Column(name = "category_id")
    private int categoryId;
    
    @Basic(optional = false)
    @Column(name = "category_name")
    private String categoryName;
    
    @Basic(optional = false)
    @Column(name = "name")
    private String name;
    
    @Basic
    @Column(name = "description")
    private String description;
    
    @Basic
    @Column(name = "original_price")
    private double originalPrice;
    
    @Basic(optional = false)
    @Column(name = "price")
    private double price;
    
    @Column(name = "image_url")
    private String imageUrl;
    
    @Column(name = "image_full_size")
    private String imageFullSize;
    
    @Column(name = "link_detail")
    private String linkDetail;
    
    @Basic
    @Column(name = "alive")
    private int alive;
    
    @Basic(optional = false)
    @Column(name = "modified_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date modifiedDate;

    @Transient
    private String beautyDes;
    
    /* selected in current order */
    @Transient
    private Boolean selected;
    
    @Transient
    private Integer quantity;
    
    @Transient
    private Long purchases;
    
    public VatgiaProduct() {
    }

    public VatgiaProduct(Integer id) {
        this.id = id;
    }

    public VatgiaProduct(Integer id, int categoryId, String categoryName, String name, double price, int alive, Date modifiedDate) {
        this.id = id;
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.name = name;
        this.price = price;
        this.alive = alive;
        this.modifiedDate = modifiedDate;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getBeautyDes() {
        if(beautyDes == null){
            if(getDescription()!=null){
                // remove all html tags
                String text = Jsoup.parse(getDescription()).text();
                // substring
                if(text.indexOf(" ", 500) > -1){
                    text = text.substring(0, text.indexOf(" ", 500))+"...";
                }
                beautyDes = text;
            }
        }
        
        return beautyDes;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getOriginalPrice() {
        return originalPrice;
    }

    public void setOriginalPrice(double originalPrice) {
        this.originalPrice = originalPrice;
    }

    public double getPriceInUSD(double exchange){
        
        double inUsd = getPrice()/exchange +0.005;
        
        return Math.round(inUsd * 100.0) / 100.0;
    }
    
    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getImageFullSize() {
        return imageFullSize;
    }

    public void setImageFullSize(String imageFullSize) {
        this.imageFullSize = imageFullSize;
    }

    public String getLinkDetail() {
        return linkDetail;
    }

    public void setLinkDetail(String linkDetail) {
        this.linkDetail = linkDetail;
    }

    public int getAlive() {
        return alive;
    }

    public void setAlive(int alive) {
        this.alive = alive;
    }
    
    public Date getModifiedDate() {
        return modifiedDate;
    }

    public void setModifiedDate(Date modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public Boolean getSelected() {
        return selected;
    }

    public void setSelected(Boolean selected) {
        this.selected = selected;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Long getPurchases() {
        return purchases;
    }

    public void setPurchases(Long purchases) {
        this.purchases = purchases;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof VatgiaProduct)) {
            return false;
        }
        VatgiaProduct other = (VatgiaProduct) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "vn.chonsoft.lixi.model.VatgiaProduct[ id=" + id + " ]";
    }
    
}
