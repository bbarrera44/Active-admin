class UserUploadJob < ActiveJob::Base
  # queue_as :default
  #
  # AdminUser = Struct.new(:emails, :password) do
  #   def perform
  #     emails.each { AdminUser.deliver_email_to_password(email, password) }
  #   end
  #   end
  #
  #   Delayed::Job.enqueue AdminUser.new(email: "pepe@gmail.com", password: '123456') #, UserUploadJob.pluck(:email).last
  #
  #
  # def destroy_failed_jobs?
  #   false
  # end

  def perform_with_feedback(xls_path)
    errors = [
        { row: 4, errors: ["Invalid Email", "Invallid"]},
        { row: 6, errors: ["Invalid Last Name"]},
        { row: 84, errors: ["Invalid ID"]}
    ]
    raise JobNotifier::Error::Validation.new(errors)
  end

  end
