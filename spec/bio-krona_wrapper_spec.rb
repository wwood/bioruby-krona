require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "BioKronaWrapper" do
  it "should give a html when you give it a simple hash" do
    html = Bio::Krona.html({
      ['Sponge','Amphimedon']=>3,
      ['Sponge','Calciums']=>4,
    })
    expected = <<EOF
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
 <head>
  <meta charset="utf-8"/>
  <link rel="shortcut icon" href="http://krona.sourceforge.net/img/favicon.ico"/>
  <script id="notfound">window.onload=function(){document.body.innerHTML="Could not get resources from \\"http://krona.sourceforge.net\\"."}</script>
  <script src="http://krona.sourceforge.net/src/krona-2.0.js"></script>
 </head>
 <body>
  <img id="hiddenImage" src="http://krona.sourceforge.net/img/hidden.png" style="display:none"/>
  <img id="loadingImage" src="http://krona.sourceforge.net/img/loading.gif" style="display:none"/>
  <img id="logo" src="http://krona.sourceforge.net/img/logo.png" style="display:none"/>
  <noscript>Javascript must be enabled to view this page.</noscript>
  <div style="display:none">
  <krona collapse="true" key="true">
   <attributes magnitude="magnitude">
    <list>members</list>
    <attribute display="Total">magnitude</attribute>
   </attributes>
   <datasets>
    <dataset>input</dataset>
   </datasets>
<node name="all">
 <magnitude><val>7</val></magnitude>
 <node name="Sponge">
  <magnitude><val>7</val></magnitude>
  <node name="Amphimedon">
   <magnitude><val>3</val></magnitude>
  </node>
  <node name="Calciums">
   <magnitude><val>4</val></magnitude>
  </node>
 </node>
</node>
  </krona>
</div></body></html>
EOF
    make_comparable = lambda do |string|
      string.split("\n").reject{|line| line.match(/<dataset>/)}
    end
    expected = make_comparable.call(expected)
    html = make_comparable.call(html)

    html.should eq(expected)
  end

  # it "should give back the html split up for re-use" do
    # h = Bio::Krona.reusable_html_chunks({
      # ['Sponge','Amphimedon']=>3,
      # ['Sponge','Calciums']=>4,
    # })
  # end

  it 'should use a specified URL for the krona assets when set to' do
    html = Bio::Krona.html({
      ['Sponge','Amphimedon']=>3,
      ['Sponge','Calciums']=>4,
    }, :resources_url => 'http://dummy.com')

    html.should match('script src="http://dummy.com')
  end

  it "should give a html with multiple samples" do
    html = Bio::Krona.html({'sample1' => {
      ['Sponge','Amphimedon']=>3,
      ['Sponge','Calciums']=>4,
      },
      'sample2' => {
        ['Sponge','Amphimedon']=>30,
      ['Sponge','Calciums']=>45,
      }
      }, :multiple_samples => true)
    html.should == '<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"en\" lang=\"en\">\n <head>\n  <meta charset=\"utf-8\"/>\n  <link rel=\"shortcut icon\" href=\"http://krona.sourceforge.net/img/favicon.ico\"/>\n  <script id=\"notfound\">window.onload=function(){document.body.innerHTML=\"Could not get resources from \\\"http://krona.sourceforge.net\\\".\"}</script>\n  <script src=\"http://krona.sourceforge.net/src/krona-2.0.js\"></script>\n </head>\n <body>\n  <img id=\"hiddenImage\" src=\"http://krona.sourceforge.net/img/hidden.png\" style=\"display:none\"/>\n  <img id=\"loadingImage\" src=\"http://krona.sourceforge.net/img/loading.gif\" style=\"display:none\"/>\n  <noscript>Javascript must be enabled to view this page.</noscript>\n  <div style=\"display:none\">\n  <krona collapse=\"true\" key=\"true\">\n   <attributes magnitude=\"magnitude\">\n    <list>members</list>\n    <attribute display=\"Total\">magnitude</attribute>\n   </attributes>\n   <datasets>\n    <dataset>sample1</dataset>\n    <dataset>sample2</dataset>\n   </datasets>\n<node name=\"all\">\n <magnitude><val>7</val><val>75</val></magnitude>\n <node name=\"Sponge\">\n  <magnitude><val>7</val><val>75</val></magnitude>\n  <node name=\"Amphimedon\">\n   <magnitude><val>3</val><val>30</val></magnitude>\n  </node>\n  <node name=\"Calciums\">\n   <magnitude><val>4</val><val>45</val></magnitude>\n  </node>\n </node>\n</node>\n  </krona>\n</div></body></html>\n" (using ==)
       Diff:
       @@ -1 +1,37 @@
       <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
       <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
        <head>
         <meta charset="utf-8"/>
         <link rel="shortcut icon" href="http://krona.sourceforge.net/img/favicon.ico"/>
         <script id="notfound">window.onload=function(){document.body.innerHTML="Could not get resources from \"http://krona.sourceforge.net\"."}</script>
         <script src="http://krona.sourceforge.net/src/krona-2.0.js"></script>
        </head>
        <body>
         <img id="hiddenImage" src="http://krona.sourceforge.net/img/hidden.png" style="display:none"/>
         <img id="loadingImage" src="http://krona.sourceforge.net/img/loading.gif" style="display:none"/>
         <noscript>Javascript must be enabled to view this page.</noscript>
         <div style="display:none">
         <krona collapse="true" key="true">
          <attributes magnitude="magnitude">
           <list>members</list>
           <attribute display="Total">magnitude</attribute>
          </attributes>
          <datasets>
           <dataset>sample1</dataset>
           <dataset>sample2</dataset>
          </datasets>
       <node name="all">
        <magnitude><val>7</val><val>75</val></magnitude>
        <node name="Sponge">
         <magnitude><val>7</val><val>75</val></magnitude>
         <node name="Amphimedon">
          <magnitude><val>3</val><val>30</val></magnitude>
         </node>
         <node name="Calciums">
          <magnitude><val>4</val><val>45</val></magnitude>
         </node>
        </node>
       </node>
         </krona>
       +</div></body></html>'
  end
end
