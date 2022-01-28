# ブロック作成
Ransack.configure do |config|

    # 実際のビューで使われるpredicateの名前を決める。
    config.add_predicate 'lteq_end_of_day',
                        # どんな動きをするかを指定
                        arel_predicate: 'lteq',
                        # vが検索されて受け取る値になる。
                        # { |v| "#{v}-diddly" }このブロック内で自分で自由にフォーマットを変えることが可能
                        formatter: proc { |v| v.end_of_day }
                        # バリデーション設定もできる。
                        # validator: proc { |v| v.present? }
                        # stringやintegerなどのオブジェクトタイプを指定できる。
                        # type: :string
                        # 大文字、小文字の区別を設定できる。デフォルトはfault。
                        # case_insensitive: :true
end