# frozen_string_literal: true

require_relative '../../lib/services/io_service'

module Services
  describe IOService, type: :model do
    let(:message) { 'sample message' }

    subject { described_class }

    it "prints 'sample message' text to stdout with newlines around it" do
      expect { described_class.print_message(message) }
        .to output("\nsample message\n")
        .to_stdout
    end

    it "prints red 'sample message' text to stderr" do
      expect { described_class.print_error(message) }
        .to output("\e[31msample message\e[0m\n")
        .to_stderr
    end

    describe '#readline' do
      let(:input_answer) { 'y' }

      before do
        allow($stdin)
          .to receive_message_chain(:gets, :chomp)
          .and_return(input_answer)
      end

      it 'reads message from input correctly' do
        expect(described_class.readline).to eq(input_answer)
      end

      it "prints by default '> ' to stdout" do
        expect { described_class.readline }
          .to output('> ')
          .to_stdout
      end

      it "prints 'message: ' to stdout" do
        expect { described_class.readline('message: ') }
          .to output('message: ')
          .to_stdout
      end
    end
  end
end
