require "uri"
require "net/http"

base_url = URI("https://www.ebi.ac.uk/Tools/services/rest/clustalo")

def service_run(email, title = nil, sequence = nil, asequence = nil,
                       style = nil, guidetreeout = true, dismatout = true,
                       dealign = false, mbed = true, mbediteration = true,
                       iterations = 0, gtiterations = -1, outfmt = "clustal_num",
                       order = "aligned")
  if sequence.nil? and [asequence, bsequence].any { |v| v.nil? }
    raise ArgumentError, "`sequence` or (`asequence`, `bsequence`) must be specified"
  end
  if !sequence.nil? and [asequence, bsequence].any { |v| !v.nil? }
    asequence = nil
    bsequence = nil
    warn "`sequence` was specified, so ignored asequence/bsequence"
  end
  url = base_url + "run"
  # Below is too difficult to maintenance
  # params = method(__callee__).parameters.map { |_, arg| [arg, binding.local_variable_get(arg)] }.to_h
  # This is not pretty but easy to maintenance
  params = { email: email, title: title, sequence: sequence, asequence: asequence,
             bsequence: bsequence, style: style, guidetreeout: guidetreeout,
             dismatout: dismatout, dealign: dealign, mbed: mbed,
             mbediteration: mbediteration, iterations: iterations,
             gtiterations: gtiterations, outfmt: outfmt, order: order }

  params.compact!
  # res = Net::HTTP.post_form(url, *{})
  url.query = URI.encode_www_form(params)
  res = Net::HTTP.post(url, headers)
end
