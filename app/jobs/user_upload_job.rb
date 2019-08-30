class UserUploadJob < ActiveJob::Base
  UserUploadJob =Struct.new(:id, :email)
  # def perform
  #   emails.each { |e|  }
  # end
  def perform_with_feedback(xls)
    errors = [
    { row: 4, errors: ["Invalid Email", "Invallid"]},
    # { row: 6, errors: ["Invalid Last Name"]},
    # { row: 84, errors: ["Invalid ID"]}
    ]
    raise JobNotifier::Error::Validation.new(errors)
  end


end