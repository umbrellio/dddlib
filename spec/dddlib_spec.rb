# frozen_string_literal: true

RSpec.describe DDDLib do
  it "has a version number" do
    expect(DDDLib::VERSION).not_to be nil
  end

  it "handles requiring files separately" do
    results = []
    failures = []

    Parallel.each(Dir["./lib/**/*.rb"], in_threads: Parallel.processor_count) do |path|
      command = Shellwords.join(["bundle", "exec", "ruby", path])

      Open3.popen2e(command) do |_in_io, out_io, wait_thr|
        status = wait_thr.value
        output = out_io.read
        results << [command, status, output]
        failures << [command, output, "-" * 80].join("\n") unless status.success?
      end
    end

    expect(failures.size)
      .to eq(0), "#{failures.size}/#{results.size} requires failed.\n#{failures.join("\n\n")}"
  end
end
