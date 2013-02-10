module Admin
  class PetitionsController < AdminController
    before_filter :get_petition, only: [:show, :edit, :update]

    def index
      @petitions = Petition.order('id desc')
    end

    def show; end

    def new
      @petition = Petition.new
    end

    def create
      @petition = current_user.petitions.new(params[:petition])
      if @petition.save
        redirect_to admin_petition_url(@petition), flash: { success: "Petition successfully created." }
      else
        render :new
      end
    end

    def edit; end

    def update
      if @petition.update_attributes(params[:petition])
        redirect_to admin_petition_url(@petition), flash: { success: "Petition successfully updated." }
      else
        render :edit
      end
    end

    private
    def get_petition
      @petition = Petition.find(params[:id])
    end
  end
end
