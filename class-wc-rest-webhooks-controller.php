<?php
/**
 * REST API Webhooks controller
 *
 * Handles requests to the /webhooks endpoint.
 *
 * @package WooCommerce\RestApi
 * @since   2.6.0
 */

defined( 'ABSPATH' ) || exit;

/**
 * REST API Webhooks controller class.
 *
 * @package WooCommerce\RestApi
 * @extends WC_REST_Webhooks_V2_Controller
 */
class WC_REST_Webhooks_Controller extends WC_REST_Webhooks_V2_Controller {

	/**
	 * Endpoint namespace.
	 *
	 * @var string
	 */
	protected $namespace = 'wc/v3';

	/**
	 * Get the default REST API version.
	 *
	 * @since  3.0.0
	 * @return string
	 */
	protected function get_default_api_version() {
		return 'wp_api_v3';
	}

		protected $rest_base = 'custom';

		function woocomm_add_to_cart($param) {

			global $wpdb;
			$user_id = $param['user_id'];
			wp_set_current_user($user_id);
			
			$objProduct = new WC_Session_handler();
		       $wc_session_data = $objProduct->get_session($user_id);
				$full_user_meta = get_user_meta($user_id,'_woocommerce_persistent_cart_1',true);

			if( defined('WC_ABSPATH')) {
				include_once WC_ABSPATH . 'includes/wc-cart-functions.php';
				include_once WC_ABSPATH . 'includes/wc-notice-functions.php';
				include_once WC_ABSPATH . 'includes/wc-template-functions.php';
			}

		if(null === WC()->sessions) {
				$session_class = apply_filters('woocommerce_session_handler', 'WC_Session_Handler');
				WC()->session = new $session_class();
				WC()->session->init();
			}

			if( null === WC()->customer) {
  				WC()->customer = new WC_Customer(get_current_user_id(), true);
			}

			if( null === WC()->cart) {
				WC()->cart = new WC_Cart();
				WC()->cart->get_cart();
			}	

			$cartObj = WC()->cart;
				if($full_user_meta['cart']){

				foreach($full_user_meta['cart'] as $single_user_meta) {
					$cartObj->add_to_cart($single_user_meta['product_id'],$single_user_meta['quantity']);
				}
			}

			

			if($param['products'] == '' or $param['products'] == null)
			{
				WC()->cart->empty_cart();
			}
			if($param['products']){
				WC()->cart->empty_cart();
				foreach($param['products'] as $prod) {
					$cartObj->add_to_cart($prod['product_id'],$prod['quantity']);
				}
			}

			$updatedCart = [];
			foreach($cartObj->cart_contents as $key => $val) {
				unset($val['data']);
				$updatedCart[$key] = $val;
			}

			if($wc_session_data){
				$wc_session_data['cart'] = serialize($updatedCart);
				$serializedObj = maybe_serialize($wc_session_data);

				$table_name = $wpdb->prefix .'woocommerce_sessions';
				$sql ="UPDATE $table_name SET session_value = '".$serializedObj."' WHERE session_key = '".$user_id."'"; 
				$rez = $wpdb->query($sql);
			}
			$full_user_meta['cart'] = $updatedCart;
			$productsInCart = [];
			foreach($cartObj->cart_contents as $cart_item){
				$product = wc_get_product($cart_item['product_id']);
				$image_id = $product->get_image_id();
				$image_url = wp_get_attachment_image_url($image_id , 'full');
				$productsInCart[] = (object) [
				"product_id" => $cart_item['product_id'],
				"product_name" => $product->get_name(),
				"product_regular_price" => $product->get_regular_price(),
				"product_sale_price" => $product->get_sale_price(),
					"thumbnail"=> $image_url,
				"qty" => $cart_item['quantity'],
				"line_subtotal" =>$cart_item['line_subtotal'],
				"line_total" => $cart_item['line_total'],
				];
			}

			update_user_meta(get_current_user_id(),'_woocommerce_persistent_cart_1',array('cart'=>$updatedCart,));
			
		$response = [
		'status' => true,
		'data' => $full_user_meta['cart'] !=  null ? $productsInCart : []
		];
		return rest_ensure_response($response);

	
	}

	function woocomm_cart_list($param){

				global $wpdb;
	$user_id = $param['user_id'];
	$objProduct = new WC_Session_handler();
	$wc_session_data = $objProduct->get_session($user_id);
	$full_user_meta = get_user_meta($user_id,'_woocommerce_persistent_cart_1',true);
	$productsInCart = [];
		foreach($full_user_meta['cart']  as $cart_item){
			$product = wc_get_product($cart_item['product_id']);
			$image_id = $product->get_image_id();
			$image_url = wp_get_attachment_image_url($image_id , 'full');
			$productsInCart[] = (object) [
			"product_id" => $cart_item['product_id'],
			"product_name" => $product->get_name(),
			"product_regular_price" => $product->get_regular_price(),
			"product_sale_price" => $product->get_sale_price(),
				"thumbnail"=> $image_url,
			"qty" => $cart_item['quantity'],
			"line_subtotal" =>$cart_item['line_subtotal'],
			"line_total" => $cart_item['line_total'],
			];
		}

		$response = [
		'status' => true,
		'data' =>$full_user_meta['cart'] !=  null ? $productsInCart : []
		];
		return rest_ensure_response($response);

	}
	
	public function register_routes(){
		register_rest_route(
			$this->namespace, 
			'/addtocart',
			array('methods' => 'POST','callback' => array($this,'woocomm_add_to_cart'),
		)
		);

		register_rest_route(
			
			$this->namespace,
			'/cart',
			 array('methods' => 'GET','callback' => array($this,'woocomm_cart_list'),
		)
		);
	}
	

}
