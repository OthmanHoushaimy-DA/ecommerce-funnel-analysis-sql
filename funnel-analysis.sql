-- E-commerce Funnel Analysis
-- This script analyzes user behavior across a 5-stage funnel:
-- page_view → add_to_cart → checkout_start → payment_info → purchase
-- It includes:
-- 1. Funnel stage counts
-- 2. Conversion rates
-- 3. Traffic source performance
-- 4. Time-to-conversion analysis
-- 5. Revenue metrics

select *
from user_events;

-- 1) define sales funnel and different stages 

WITH funnel_stages AS (

 SELECT COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS stage_1_views,
		COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN user_id END) AS stage_2_cart,
        COUNT(DISTINCT CASE WHEN event_type = 'checkout_start' THEN user_id END) AS stage_3_checkout,
        COUNT(DISTINCT CASE WHEN event_type = 'payment_info' THEN user_id END) AS stage_4_payment,
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS stage_5_purchase

 FROM user_events 
 WHERE event_date BETWEEN DATE_SUB('2026-02-03', INTERVAL 30 DAY) AND '2026-02-03'
 )
 
 SELECT * FROM funnel_stages;
 
 -- 2) calculate the conversion rates between stages and overall conversion rate
 
 WITH funnel_stages AS (

 SELECT COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS stage_1_views,
		COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN user_id END) AS stage_2_cart,
        COUNT(DISTINCT CASE WHEN event_type = 'checkout_start' THEN user_id END) AS stage_3_checkout,
        COUNT(DISTINCT CASE WHEN event_type = 'payment_info' THEN user_id END) AS stage_4_payment,
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS stage_5_purchase

 FROM user_events 
 WHERE event_date BETWEEN DATE_SUB('2026-02-03', INTERVAL 30 DAY) AND '2026-02-03'
 )
 
 SELECT stage_1_views,
		stage_2_cart,
        round(stage_2_cart * 100 / stage_1_views) AS views_to_cart_rate,
        stage_3_checkout,
        round(stage_3_checkout * 100 / stage_2_cart) AS cart_to_chekout_rate,
        stage_4_payment,
        round(stage_4_payment * 100 / stage_3_checkout) AS checkout_to_payment_rate,
        stage_5_purchase,
        round(stage_5_purchase * 100 / stage_4_payment) AS payment_to_purchase_rate,
        round(stage_5_purchase * 100/ stage_1_views) AS overall_rate
        
from funnel_stages;

-- 3) funnel by source analysis

WITH source_funnel AS ( 

		SELECT
		traffic_source,
		COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS views,
		COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN user_id END) AS cart,
		COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS purchase

FROM user_events 
WHERE event_date BETWEEN DATE_SUB('2026-02-03', INTERVAL 30 DAY) AND '2026-02-03'
GROUP BY traffic_source
 )
 
 Select traffic_source,
		views,
        cart,
        purchase,
        ROUND(cart * 100 / views) as cart_conversion_rate,
        ROUND(purchase * 100/ views) as purchase_conversion_rate,
        ROUND(purchase * 100 / cart) as cart_to_purchase_conversion_rate
from source_funnel
Order by purchase desc;

-- 4) time to conversion analysis

WITH user_journey AS ( 

		SELECT
		user_id,
		MIN(CASE WHEN event_type = 'page_view' THEN event_date END) AS view_time,
		MIN(CASE WHEN event_type = 'add_to_cart' THEN event_date END) AS cart_time,
		MIN(CASE WHEN event_type = 'purchase' THEN event_date END) AS purchase_time

FROM user_events 
WHERE event_date BETWEEN DATE_SUB('2026-02-03', INTERVAL 30 DAY) AND '2026-02-03'
GROUP BY user_id
HAVING MIN(CASE WHEN event_type = 'purchase' THEN event_date END) IS NOT NULL
 )
 
 SELECT
	count(*) AS converted_users,
    round(AVG(TIMESTAMPDIFF(MINUTE, view_time, cart_time)), 2) AS avg_view_to_cart_minutes,
    round(AVG(TIMESTAMPDIFF(MINUTE, cart_time, purchase_time)), 2) AS avg_cart_to_purchase_minutes,
    round(AVG(TIMESTAMPDIFF(MINUTE, view_time, purchase_time)), 2) AS avg_total_journey_minutes,

FROM user_journey;

-- 5) revenue funnel analysis

WITH funnel_revenue AS(
	SELECT
		COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS total_visitors,
        COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END)	AS total_buyers,
        SUM(CASE WHEN event_type = 'purchase' THEN amount END) AS total_revenue,
        COUNT(CASE WHEN event_type = 'purchase' THEN 1 END) AS total_orders
        
FROM user_events
WHERE event_date BETWEEN DATE_SUB('2026-02-03', INTERVAL 30 DAY) AND '2026-02-03'
)

SELECT
	total_visitors,
    total_buyers,
    total_orders,
    total_revenue,
    total_revenue / total_orders AS avg_order_value,
    total_revenue / total_buyers AS revenue_per_buyer,
    total_revenue / total_visitors AS revenue_per_visitor
    
FROM funnel_revenue;
    

    
    
        



    
  




        

 

        
        
        
        
		
