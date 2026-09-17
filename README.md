# 🍕 Pizza Sales SQL Analysis

## 📌 Project Overview

This project analyzes pizza sales data using MySQL to understand
sales performance, customer ordering patterns, popular pizza types,
and revenue contribution.

The project demonstrates practical SQL skills including:

- SQL Joins
- Aggregate Functions
- GROUP BY
- ORDER BY
- Subqueries
- Common Table Expressions (CTEs)
- Window Functions
- ROW_NUMBER()
- Date and Time Functions

---

## 🗂️ Dataset

The dataset contains four relational tables:

### 1. orders
Contains information about customer orders.

Columns:
- order_id
- date
- time

### 2. order_details
Contains details of pizzas included in each order.

Columns:
- order_details_id
- order_id
- pizza_id
- quantity

### 3. pizzas
Contains pizza size and pricing information.

Columns:
- pizza_id
- pizza_type_id
- size
- price

### 4. pizza_types
Contains pizza names, categories and ingredients.

Columns:
- pizza_type_id
- name
- category
- ingredients

---

## 🔗 Database Relationships

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