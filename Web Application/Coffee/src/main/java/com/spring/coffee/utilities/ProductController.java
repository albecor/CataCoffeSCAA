/**
 * 
 */
package com.spring.coffee.utilities;

import java.util.List;

public class ProductController {

	private static ProductCollection productCollection;

	public static List<Product> loadProductCollection() {
		fillCollection();
		return productCollection.getListProducts();

	}

	private static void fillCollection() {
		productCollection = new ProductCollection();
		productCollection.addProduct(new Product(1, "la referencia", "strocksa", true));
	}

}