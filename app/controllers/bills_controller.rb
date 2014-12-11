class BillsController < ApplicationController

  respond_to :html

  def index
    @bills = Bill.all.paginate(page: params[:page], per_page: 5)
    respond_with(@bills)
  end


  def show
    set_bill
    respond_with(@bill)
  end

  def new
    @bill = Bill.new
    respond_with(@bill)
  end

  def edit
  end

  def create
    @bill = Bill.new(bill_params)
    if @bill.save
      calculate_balance
    end
    respond_with(@bill)
  end

  def calculate_balance
    params[:bill][:payedby].reject!(&:empty?).each do |user_id|
      json = {'user_id' => "#{user_id}", 'bill_id' => "#{@bill.id}"}
      InvolvedInBill.new(json).save
    end
    InvolvedInBill.new({'user_id' => "#{@bill.user_id}", 'bill_id' => "#{@bill.id}"}).save
    pos_user=User.find_by(id: @bill.user_id)
    frac_val = ((@bill.value)/((params[:bill][:payedby].size) + 1))
    params[:bill][:payedby].each do |id|
      User.find_by(id: id).update_attributes(balance: "#{User.find_by(id: id).balance  - frac_val})")
    end
    pos_user.update_attributes(balance: "#{User.find_by(id: @bill.user_id).balance + @bill.value - frac_val}")
  end

  def update
    @bill.update(bill_params)
    respond_with(@bill)
  end

  def destroy
    set_bill
    @bill.destroy
    respond_with(@bill)
  end

  private
  def set_bill
    @bill = Bill.find(params[:id])
  end

  def find_corresponding_user
    @user = User.where(id: @bill.user_id)
  end

  def bill_params
    params.require(:bill).permit(:value, :user_id, :market_id, :created_at)
  end
end
