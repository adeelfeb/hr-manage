# 🧑‍💼 HR Management System

A simple Human Resource Management System built with **Ruby on Rails** to manage employees and their documents. This project was developed for learning purposes and covers CRUD operations, model associations, validations, and file attachments using Active Storage.

## 🚀 Features

- ✅ **Employee Management**
  - Add, view, edit, and delete employee records
  - Validation for email, phone, and required fields

- 📄 **Document Management**
  - Associate documents with employees
  - Upload and display document images using Active Storage
  - Show documents with associated employee names

- 🗂️ **Associations**
  - `Employee has_many :documents`
  - `Document belongs_to :employee`

- 🧪 **Validations**
  - Ensures presence and format of important fields

- 🖼️ **Image Uploading**
  - Uses Active Storage to attach images to documents
  - Displays uploaded images in the UI

- 🌐 **Navigation**
  - Simple Bootstrap-styled navbar
  - Links to employees and documents index pages
  - Actions inside dropdown menus

- 💬 **Flash Notices**
  - Success/error messages for actions like create, update, delete
  - Auto-hiding flash messages

## 🛠️ Tech Stack

- **Ruby**: 3.x
- **Rails**: 7.x
- **Database**: SQLite (can be swapped with PostgreSQL)
- **Front-end**: Bootstrap 5
- **Active Storage**: For image attachments

## 📂 Project Structure

- `app/models/employee.rb`: Employee model with validations
- `app/models/document.rb`: Document model with `belongs_to :employee`
- `app/controllers/employees_controller.rb`: Employee CRUD logic
- `app/controllers/documents_controller.rb`: Document CRUD logic
- `app/views/employees/`: Employee views (index, show, edit, new)
- `app/views/documents/`: Document views (index, show, edit, new)
- `config/routes.rb`: Resourceful routes for both models

## 📷 Screenshots

> You can include screenshots here of the employee list, document upload, and detail pages for better clarity.

## ✅ Getting Started

### Prerequisites

- Ruby & Rails installed
- SQLite or preferred DB setup

### Setup Instructions

```bash
git clone https://github.com/your-username/hr-manage.git
cd hr-manage
bundle install
rails db:migrate
rails server
