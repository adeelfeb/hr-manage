class DocumentsController < ApplicationController
  before_action :authenticate_user! # Ensure Devise user is logged in
  before_action :set_document, only: [:edit, :update, :show, :destroy]

  def index
    # Optional: scope based on policy (e.g., only show documents user is allowed to see)
    @documents = policy_scope(Document)
  end

  def new
    @document = Document.new
    authorize @document
  end

  def create
    @document = Document.new(document_params)
    authorize @document

    if @document.save
      redirect_to documents_path, notice: "Document added successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @document
  end

  def update
    authorize @document

    if @document.update(document_params)
      redirect_to documents_path, notice: "Document updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @document

    if @document.destroy
      redirect_to documents_path, notice: "Document deleted successfully"
    end
  end

  def show
    authorize @document
  end

  private

  def document_params
    params.require(:document).permit(:name, :doc_type, :employee_id, :image)
  end

  def set_document
    @document = Document.find(params[:id])
  rescue ActiveRecord::RecordNotFound => error
    redirect_to documents_path, notice: error.message
  end
end
