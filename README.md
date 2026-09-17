# 🍕 Pizza Sales SQL Analysis

## 📊 Project Overview

This project analyzes pizza sales data using **MySQL and SQL** to uncover business insights related to orders, sales volume, customer preferences, and revenue performance.

The project demonstrates how relational data can be transformed into meaningful business insights using SQL queries, aggregations, joins, subqueries, CTEs, and window functions.

---

## 🎯 Objectives

The analysis focuses on answering questions such as:

- How many orders were placed?
- How much revenue was generated?
- Which pizzas are ordered the most?
- Which pizza size is most popular?
- Which pizza categories generate the most sales?
- Which pizzas generate the highest revenue?
- How does revenue change over time?
- Which pizzas perform best within each category?

---

## 🛠️ Tools & Technologies

- **MySQL**
- **SQL**
- **Git**
- **GitHub**

### SQL Concepts Used

- SELECT
- WHERE
- GROUP BY
- ORDER BY
- JOIN
- Aggregate Functions
- CASE Statements
- Subqueries
- Common Table Expressions (CTEs)
- Window Functions
- `ROW_NUMBER()`
- Date & Time Functions
- Ranking
- Cumulative Analysis

---

# 🗄️ Database Schema

The dataset consists of four related tables:

### `orders`

Contains information about customer orders.

| Column | Description |
|---|---|
| order_id | Unique order identifier |
| date | Date of the order |
| time | Time of the order |

### `order_details`

Contains individual pizza items within each order.

| Column | Description |
|---|---|
| order_details_id | Unique order-detail identifier |
| order_id | Order identifier |
| pizza_id | Pizza identifier |
| quantity | Quantity ordered |

### `pizzas`

Contains pizza pricing and size information.

| Column | Description |
|---|---|
| pizza_id | Unique pizza identifier |
| pizza_type_id | Pizza type identifier |
| size | Pizza size |
| price | Pizza price |

### `pizza_types`

Contains pizza names, categories, and ingredients.

| Column | Description |
|---|---|
| pizza_type_id | Pizza type identifier |
| name | Pizza name |
| category | Pizza category |
| ingredients | Pizza ingredients |

---

## 🔗 Table Relationships

```text
pizza_types
     │
     │ pizza_type_id
     ▼
  pizzas
     │
     │ pizza_id
     ▼
order_details
     │
     │ order_id
     ▼
  orders
