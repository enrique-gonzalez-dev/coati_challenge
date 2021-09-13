class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  protect_from_forgery with: :exception

  # GET /tickets or /tickets.json
  def index
    @tickets = Ticket.all
  end

  # GET /tickets/1 or /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets or /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: "Ticket was successfully created." }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1 or /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: "Ticket was successfully updated." }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1 or /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: "Ticket was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  #Import function

  def import
    
  end
  def read_import
    file = import_params[:import_file]
    opened_file = File.open(file)
    result = opened_file.read
    rows = FastestCSV.read(file)
    rows.each_with_index do |row, index|
      row_s = row[0].to_s
      result_row = row_s.split(/\t/,-1)
      if index > 0
        client_name = result_row[0]
        item_description = result_row[1]
        item_cost = result_row[2].to_f
        total_items = result_row[3].to_i
        seller_addres = result_row[4]
        seller_name = result_row[5]
        client_id = get_client_id(client_name)
        seller_id = get_seller_id(seller_name,seller_addres)
        product_id = get_prodcut_id(item_description, item_cost)
        transaction_amount = total_items.to_i * item_cost.to_f
        debugger
        @ticket = Ticket.new(total_items: total_items, client_id: client_id, seller_id: seller_id,transaction_amount: transaction_amount , product_id: product_id)
        @ticket.save
      end
    end
    redirect_to tickets_path, notice: "Datos importados" 
  end
  def get_client_id(name)
    client = Client.find_by(name: name)
    if client.nil?
      client = Client.new(name: name)
      client.save
      return client.id
    else
      return client.id
    end
  end

  def get_seller_id(name, addres)
    seller = Seller.find_by(name: name)
    if seller.nil?
      seller = Seller.new(name: name, address: addres)
      seller.save
      return seller.id
    else
      return seller.id
    end
  end
  def get_prodcut_id(description, cost)
    product = Product.find_by(description: description, cost: cost)
    if product.nil?
      product = Product.new(description: description, cost: cost)
      product.save
      return product.id
    else
      return product.id
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ticket_params
      params.require(:ticket).permit(:total_items, :transaction_amount)
    end

    def import_params
      params.require(:ticket).permit(:import_file)
    end
end
