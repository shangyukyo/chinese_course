class Admin::ProductsController < Admin::ApplicationController
	before_action :find_product, only: [:edit, :update]

	def index
		@products = Product
			.order('id desc')
			.paginate(page: params[:page], per_page: 10)		
	end

	def new		
	end

	def create
		begin
			if product_params[:price].to_f < 0
				flash[:alert] = '商品价格不能为负数'
				render :new
			elsif !product_params[:name].present?
				flash[:alert] = '商品名称不能为空'
				render :new		
			else
				@product = Product.create! product_params
				redirect_to admin_products_path				
			end
		rescue => e			
			flash[:alert] = '创建商品出错, 商品名称不能为空， 价格要大于0'
			render :new		
		end
	end

	def edit
	end

	def update
		begin
			@product.name = product_params[:name]
			@product.price = product_params[:price]
			@product.number_of_lessons = product_params[:number_of_lessons]
			@product.description = product_params[:description]
			@product.save!
			redirect_to admin_products_path	
		rescue => e
			flash[:alert] = '修改商品出错, 商品名称不能为空， 价格要大于0'
			render :new					
		end
	end

	def upload_photo
		uploader = ProductUploader.new
		uploader.store! params[:Filedata]
		puts uploader.inspect
    # extname = params[:Filedata].content_type.split('/').last.downcase    
    # asset = Asset::ProductPicture.new
    # asset.user = current_user
    # asset.filename = "#{SecureRandom.hex(5)}.#{extname.downcase}"
    # asset.save!
    # code, result, response_headers = asset.upload params[:Filedata].tempfile.path

    # render json: {asset_id: asset.id.to_s, preview: asset.url(:small)}		
	end

	private

	def product_params
		params.permit(:name, :price, :description, :number_of_lessons)
	end

	def find_product
		@product = Product.find params[:id]
	end
end