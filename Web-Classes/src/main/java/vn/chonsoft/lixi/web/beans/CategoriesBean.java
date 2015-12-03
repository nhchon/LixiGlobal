/*
 * Lixi is a Vietnamese word for small gift of money
 * 2015 @ Lixi Global
 */
package vn.chonsoft.lixi.web.beans;

import vn.chonsoft.lixi.model.LixiCategory;

/**
 *
 * @author chonnh
 */
public class CategoriesBean {
    
    private LixiCategory candies;
    private LixiCategory jewelries;
    private LixiCategory flowers;
    private LixiCategory childrentoy;
    private LixiCategory perfume;
    private LixiCategory cosmetics;

    /**
     * 
     * @param id
     * @return 
     */
    public LixiCategory getById(int id){
    
        if(id == jewelries.getId()) return jewelries;
        if(id == flowers.getId()) return flowers;
        if(id == childrentoy.getId()) return childrentoy;
        if(id == perfume.getId()) return perfume;
        if(id == cosmetics.getId()) return cosmetics;
        /* default */
        return candies;
    }
    
    public LixiCategory getCandies() {
        return candies;
    }

    public void setCandies(LixiCategory candies) {
        this.candies = candies;
    }

    public LixiCategory getJewelries() {
        return jewelries;
    }

    public void setJewelries(LixiCategory jewelries) {
        this.jewelries = jewelries;
    }

    public LixiCategory getFlowers() {
        return flowers;
    }

    public void setFlowers(LixiCategory flowers) {
        this.flowers = flowers;
    }

    public LixiCategory getChildrentoy() {
        return childrentoy;
    }

    public void setChildrentoy(LixiCategory childrentoy) {
        this.childrentoy = childrentoy;
    }

    public LixiCategory getPerfume() {
        return perfume;
    }

    public void setPerfume(LixiCategory perfume) {
        this.perfume = perfume;
    }

    public LixiCategory getCosmetics() {
        return cosmetics;
    }

    public void setCosmetics(LixiCategory cosmetics) {
        this.cosmetics = cosmetics;
    }
}
