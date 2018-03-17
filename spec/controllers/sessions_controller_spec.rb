require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:admin) { FactoryBot.create(:admin) }

  describe "GET new" do
    before do
      get :new
    end
    it "has a 200 status code." do
      expect(response.status).to eq(200)
    end
    it "reders the new template." do
      expect(response).to render_template("new")
    end
  end

  describe "POST create" do
    context "when admin user is exists" do
      context "when the authentication succeeds" do
        before do
          post :create, session: {
            email: admin.email,
            password: admin.password
          }
        end
        it "the remember token save in cookies." do
          cookies_remenber_token = Admin.encrypt(response.cookies["remember_token"])
          expect(Admin.find_by(remember_token: cookies_remenber_token)).to eq(admin)
        end
        it "assigns current_user." do
          expect(assigns(:current_user)).to eq(admin)
        end
        it "redirect root path." do
          expect(response).to redirect_to(root_path)
        end
      end
      context "when the authentication fails" do
        before do
          post :create, session: {
            email: admin.email,
            password: 999999999
          }
        end
        it "has a flash[:danger]." do
          expect(flash[:danger]).to eq("Invalid email/password combination")
        end
        it "render the new template." do
          expect(response).to render_template(:new)
        end
      end
    end
    context "when admin user is not exists" do
      before do
        post :create, session: {
          email: "test@admin.com",
          password: 999999999
        }
      end
      it "has a flash[:danger]." do
        expect(flash[:danger]).to eq("Invalid email/password combination")
      end
      it "render the new template." do
        expect(response).to render_template(:new)
      end
    end
  end
end