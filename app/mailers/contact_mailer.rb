class ContactMailer < ActionMailer::Base
    default to: 'Matthias.Scharfen25@web.de'
    
    def contact_email(name, email, body)
        @name= name
        @email = email
        @body = body
        
        mail(from: email, subject: 'Kontaktnachricht')
    end
end