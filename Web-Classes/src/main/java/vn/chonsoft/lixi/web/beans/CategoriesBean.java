/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.beans;

/**
 *
 * @author chonnh
 */
public class CategoriesBean {
    
    private Category candies;
    private Category jewelries;
    private Category flowers;
    private Category childrentoy;
    private Category perfume;
    private Category cosmetics;

    public Category getCandies() {
        return candies;
    }

    public void setCandies(Category candies) {
        this.candies = candies;
    }

    public Category getJewelries() {
        return jewelries;
    }

    public void setJewelries(Category jewelries) {
        this.jewelries = jewelries;
    }

    public Category getFlowers() {
        return flowers;
    }

    public void setFlowers(Category flowers) {
        this.flowers = flowers;
    }

    public Category getChildrentoy() {
        return childrentoy;
    }

    public void setChildrentoy(Category childrentoy) {
        this.childrentoy = childrentoy;
    }

    public Category getPerfume() {
        return perfume;
    }

    public void setPerfume(Category perfume) {
        this.perfume = perfume;
    }

    public Category getCosmetics() {
        return cosmetics;
    }

    public void setCosmetics(Category cosmetics) {
        this.cosmetics = cosmetics;
    }
    
    
    public class Category {

        private Integer id;
        private String en;
        private String vn;

        public Category(Integer id, String en, String vn) {

            this.id = id;
            this.en = en;
            this.vn = vn;

        }

        public Category(String[] arrs) {

            this.id = Integer.parseInt(arrs[0]);
            this.en = arrs[1];
            this.vn = arrs[2];

        }

        public Integer getId() {
            return id;
        }

        public void setId(Integer id) {
            this.id = id;
        }

        public String getEn() {
            return en;
        }

        public void setEn(String en) {
            this.en = en;
        }

        public String getVn() {
            return vn;
        }

        public void setVn(String vn) {
            this.vn = vn;
        }

    }
}
