# view
`
<%= form_for(@company_form, url: { action: 'create' }) do |f| %>
  <%= f.error_notification %>
  <%= f.input :name %>
  <%= f.fields_for :phones do |phone_form| %>
    <%= phone_form.input :number, label: 'Phone' %>
  <% end %>
  <%= f.button :submit, 'Submit' %>
<% end %>
`

# controller
def new
  @company_form = CompanyForm.new(Company.new)
  @company_form.prepopulate!
  # populators    - :create, :update
  # prepopulators - :new, :edit
end

def create
  @company_form = CompanyForm.new(Company.new)
  if @company_form.vaidate(params[:company])
    @company_form.save
    redirect_to edit_company_address_path(@company_form.model.id),
                notice: 'Success'
  else
    render :new
  end
end

# form object
class CompanyForm < Reform::Form
  property :name
  validates :name, presence: true

  collection :phones, prepopulator: :build_phone,
                      populate_if_empty: Phone do
    property :number
    property :primary, default: true

    validates :primary, presence: true
  end

  private

  def build_phone(*)
    phones << Phone.new if phones.blank?
  end
end
