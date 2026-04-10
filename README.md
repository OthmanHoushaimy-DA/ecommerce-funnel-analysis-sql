# E-commerce Funnel & Conversion Analysis (SQL)

## 📊 Project Overview

This project analyzes user behavior across an e-commerce funnel using SQL.  
The goal is to understand how users progress through different stages, identify drop-offs, measure conversion efficiency, and connect user behavior to revenue performance.

---

## 📁 Dataset

The dataset contains user-level event tracking with the following columns:

- user_id  
- event_type (page_view, add_to_cart, checkout_start, payment_info, purchase)  
- event_date  
- product_id  
- amount  
- traffic_source  

---

## 🔍 Analysis Performed

### 1. Funnel Analysis
- Measured the number of unique users at each stage of the funnel:
  - Page View → Add to Cart → Checkout → Payment → Purchase  
- Identified where users drop off

---

### 2. Conversion Rate Analysis
- Calculated step-by-step conversion rates between each stage  
- Measured overall conversion rate from visit to purchase  

---

### 3. Traffic Source Performance
- Analyzed user behavior by traffic source  
- Compared conversion efficiency across channels  
- Identified high-performing and low-performing acquisition sources  

---

### 4. Time-to-Conversion Analysis
- Calculated time between key stages:
  - View → Cart  
  - Cart → Purchase  
  - Full journey (View → Purchase)  
- Focused on users who completed a purchase  

---

### 5. Revenue Analysis
- Total revenue and total orders  
- Average Order Value (AOV)  
- Revenue per buyer and per visitor  

---

## 💡 Key Insights & Recommendations

### 1. UX & Checkout Performance
- Conversion rate from checkout to purchase exceeds **80%**, indicating a highly efficient and frictionless payment process  
→ **Recommendation:** Avoid redesigning or modifying the checkout flow at this stage, as it is already performing optimally and changes may negatively impact conversions  

---

### 2. Marketing Strategy Optimization

- Social media drives a high volume of traffic (~30%) but has the **lowest conversion rate**, indicating low-quality or low-intent users  
→ **Recommendation:** Reduce budget allocation toward traffic-focused social media campaigns and shift toward higher-intent strategies  

- Email marketing shows the **highest conversion rate (~13%)**, significantly outperforming social media (~6%)  
→ **Recommendation:** Invest in aggressive email capture strategies (e.g., pop-ups, lead magnets) to convert social traffic into email subscribers, increasing future conversion potential  

---

### 3. Financial & Revenue Efficiency

- Average Order Value (AOV) is approximately **$115**, providing a benchmark for profitability  
→ **Recommendation:** Establish a Customer Acquisition Cost (CAC) threshold (e.g., $30–$40). Spending above this range on low-converting channels (like social media) may result in unprofitable campaigns  

---

## 🛠️ SQL Skills Used

- Common Table Expressions (CTEs)  
- Aggregations (`COUNT`, `SUM`, `AVG`)  
- Conditional logic (`CASE WHEN`)  
- `COUNT(DISTINCT ...)` for user-level analysis  
- `TIMESTAMPDIFF` for time-based analysis  
- `GROUP BY` and `HAVING`  

---

## 📂 Project Files

- `funnel_analysis.sql` → Full SQL analysis  
- `README.md` → Project documentation and insights  

---

## 🚀 Conclusion

This project demonstrates how SQL can be used not only to analyze user behavior but also to generate actionable business insights.  
By combining funnel analysis, time-to-conversion, and revenue metrics, we can make data-driven decisions to improve performance and profitability.
