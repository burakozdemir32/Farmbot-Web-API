module Sequences
  class Update < Mutations::Command
    extend AstValidators
    ast_body :optional

    required do
      model :device, class: Device
      model :sequence, class: Sequence
    end

    optional do
      string :name
      string :color, in: Sequence::COLORS
    end

    def validate
      raise Errors::Forbidden unless device.sequences.include?(sequence)
    end

    def execute
      sequence.update_attributes!(inputs.except(:sequence, :device))
      sequence
    rescue ActiveRecord::RecordInvalid => e
      case e.record
      when Sequence
        bad_sequence(e)
      else
        add_error :other, :unknown, (e.try(:message) || "Unknown validation issues.")
      end
    end

    def bad_sequence(e)
      add_error :sequence, :not_valid, e.message
    end
  end
end
