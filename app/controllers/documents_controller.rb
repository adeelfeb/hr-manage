class DocumentsController < ApplicationController
  before_action :set_document, only: [:edit, :update, :show, :destroy]

  def index
    @documents = Document.all
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)
    if @document.save
      redirect_to documents_path, notice: "Document added successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # @document is set from before_action
  end

  def update
    if @document.update(document_params)
      redirect_to documents_path, notice: "Document updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @document.destroy
      redirect_to documents_path, notice: "Document deleted successfully"
    end
  end

  def show
    # @document is set from before_action
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
