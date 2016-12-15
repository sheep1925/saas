class ContactsController < ApplicationController
   
   #GET request to /contact-us
   #Show new contact form
    def new
        @contact = Contact.new
    end
    
   # POST request /contacts
    def create 
        #Mass assigment of form field intoContact object
        @contact = Contact.new(contact_params)
        #Save Contact object to Database
        if @contact.save
            name = params[:contact][:name]
            email = params[:contact][:email]
            body = params[:contact][:comments]
            # Plug variables into COntact Mailer
            # email methode and send email
            ContactMailer.contact_email(name, email, body).deliver
            # Store success message in flash hash
            # and redirect to the new action
            flash[:success] = "Nachricht gesendet!"
            redirect_to new_contact_path
        else
            # Store errors message in flash hash
            # and redirect to the new action
            flash[:danger] = @contact.errors.full_messages.join(", ")
            redirect_to new_contact_path
         end
        end
    end
    

private
    # Collect data from form, we need to use stronger
    # parameters and whitelist 
    def contact_params
        params.require(:contact).permit(:name, :email, :comments)
    end
    
end