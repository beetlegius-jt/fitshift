module Admin
  class CompaniesController < BaseController
    before_action :set_company
    before_action :set_company_metadata

    def show
    end

    def edit
      render :form
    end

    def update
      @company.update!(company_params)

      flash.now.notice = notice_message

      respond_to do |format|
        format.turbo_stream { render_flash }
        format.html { redirect_to edit_admin_company_path, notice: notice_message }
      end
    end

    private

    def set_company
      @company = authorize Current.company
    end

    def company_params
      params.require(:company).permit(:name, :subdomain, :utc_offset, :logo)
    end

    def set_company_metadata
      set_metadata title: @company.name
    end
  end
end
