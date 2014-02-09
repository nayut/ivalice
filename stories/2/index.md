---
layout: page
title: "Jobs and Abilities"
---
{% include JB/setup %}

![WhiteMage Abilities]({{ BASE_PATH }}/stories/img/WhiteMageAbilities.png)

今度はジョブとアビリティを２つのモデルに分けて両者を関連付けます。


#### 2つのモデルのリレーションシップについて
* [Ruby on Rails: テーブル間のリレーションシップ　has_many belongs_to, has_one, has_and_belongs_to_many - FrogPadの日記](http://d.hatena.ne.jp/FrogPad/20090327/1238212954)
* [Railsで作るTwitterもどき - 篳篥日記](http://d.hatena.ne.jp/hichiriki/20081116)

フィールド名: 単数形_id の形式でつなぎます。
1つのジョブに複数のアビリティを持つので「1対多」の関係となります。


#### scaffoldのやり直し

##### destroy
    $ rails destroy scaffold ability

    $ rake db:drop

##### scaffold job

    $ rails generate scaffold job name:string

##### scaffold ability
前回 job:string だったところを job_id:integer に変更しています。
また、「アクションアビリティ(a)」「リアクションアビリティ(r)」「サポートアビリティ(s)」「ムーブアビリティ(m)」の定義 kind も追加しています。

    $ rails generate scaffold ability job_id:integer kind:string name:string mp:integer speed:integer jp:integer


#### モデルの編集

###### app/models/job.rb
<pre>
class Job &lt; ActiveRecord::Base
  attr_accessible :name
  has_many :abilities
end
</pre>

###### app/models/ability.rb
<pre>
class Ability &lt; ActiveRecord::Base
  attr_accessible :job_id, :jp, :kind, :mp, :name, :speed
  belongs_to :job
end
</pre>


##### migrate
    $ rake db:migrate


##### サーバ起動・動作確認
    $ rails s

    http://localhost:3000/jobs


#### 試しにジョブデータを作成
New Jobリンクから手入力します。

* Name: 白魔道士


#### アビリティデータ一括取込用のCSVファイルを変更
上記で作成した白魔道士の job_id は 1 となるので、それに合わせます。
###### db/seeds_data/whitemage.csv
<pre>
1,a,ケアル,6,25,50
1,a,ケアルラ,10,20,180
1,a,ケアルガ,16,15,450
1,a,ケアルジャ,20,10,800
1,a,レイズ,10,25,200
1,a,アレイズ,20,10,600
1,a,リレイズ,16,15,1000
1,a,リジェネ,8,25,350
1,a,プロテス,6,25,70
1,a,プロテジャ,24,15,600
1,a,シェル,6,25,70
1,a,シェルジャ,20,15,600
1,a,ウォール,24,25,400
1,a,エスナ,18,34,300
1,a,ホーリー,56,17,600
1,r,リジェネーター,,,400
1,s,魔法防御力ＵＰ,,,400
</pre>


#### seeds.rbの編集
###### db/seeds.rb

	- Ability.create(:job => row[0], ...
	+ Ability.create(:job_id => row[0], ...


#### 初期データとして投入
    $ rake db:seed


#### ジョブのページにアビリティリストを表示
###### app/views/jobs/show.html.erb

    <p id="notice"><%= notice %></p>

    <p>
      <b>Name:</b>
      <%= @job.name %>
    </p>

    <table>
    <% @job.abilities.each do |ability| %>
      <tr>
        <td><%= ability.kind  %></td>
        <td><%= ability.name  %></td>
        <td><%= ability.mp    %></td>
        <td><%= ability.speed %></td>
        <td><%= ability.jp    %></td>
      </tr>
    <% end %>
    </table>

    <%= link_to 'Edit', edit_job_path(@job) %> |
    <%= link_to 'Back', jobs_path %>


#### サーバ起動・動作確認
    $ rails s

    http://localhost:3000/jobs/1
