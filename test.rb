require 'webrick' #'webrick'を呼び出している

#Webrickのインスタンスを作成し、serverという名前のローカル変数に入れます。
server = WEBrick::HTTPServer.new({
  :DocumentRoot => '.', #このWebアプリケーションのドメインの設定（ここに書き込まれた記述が、作成するWebアプリケーションのドメインになる）
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby, #このプログラムを実行（翻訳）できるプログラム（Rubyのこと）本体の居場所を指定する記述。
  :Port => '3000', #このWebアプリケーションの情報の出入り口を表す設定。
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}

server.mount('', WEBrick::HTTPServlet::ERBHandler, 'test.html.erb') #Webサーバを起動した状態で、（DocumentRootの値）/testというURLを送信すると、同じディレクトリ階層にあるtest.html.erbファイルを表示する

server.mount('/goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya.rb')

server.mount('/goya2.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya2.rb')

server.start