/**
 * 
 */
package com.spring.coffee.utilities;

import java.util.ArrayList;
import java.util.List;

public class ProductCollection {

	private List<Product> productList = new ArrayList<Product>();

	public void addProduct(Product objProduct) {
		productList.add(objProduct);
	}

	public List<Product> getListProducts() {
		return productList;
	}

}