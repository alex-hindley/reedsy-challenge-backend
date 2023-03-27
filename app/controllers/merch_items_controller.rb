class MerchItemsController < ApplicationController
  include MerchHelper

  def index
    merch_items = MerchItem.all
    render json: merch_items
  end

  def update
    merch = params.require(:merch).permit(:code, :name, :price)

    merch_item = MerchItem.find(params[:id])
    merch_item.update(merch.to_hash)

    render json: merch_item
  end

  def check_price
    merch_items = MerchItem.where(id: params[:quantities].keys)
    merch_item_id_strings = merch_items.collect { |i| i[:id].to_s }
    permitted = params.require(:quantities).permit(*merch_item_id_strings).to_hash
    quantities = Hash[permitted.map { |k, v| [k.to_i, v.to_i] }]

    render plain: pretty_price_check(quantities, merch_items)
  end

  def show
    merch_item = MerchItem.find(params[:id])
    render json: merch_item
  end

  def create
    permitted = params.require(:merch).permit(:code, :name, :price).to_hash
    merch_item = MerchItem.create(permitted)
    render json: merch_item
  end

  def destroy
    merch_items = MerchItem.all
    merch_item = merch_items.find(params[:id])
    merch_item.destroy
  end
end
