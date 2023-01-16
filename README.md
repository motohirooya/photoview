# photoview概要
photoviewは地図中央に近い写真を上部に表示して、撮影位置と線で結ぶQGISスタイルで、ジオタグ付写真からレイヤを作成するモデル、パラメータ（プロジェクト変数）を設定するモデルが付属します。

<img src="/PHOTOVIEW.PNG" width="500">
<img src="https://user-images.githubusercontent.com/70827688/212680711-8d726485-8e81-488e-9f0f-e53eb02b4a95.png" width="500">


# QGISモデルの使い方
* モデルの登録 プロセッシングツールボックスパネルの上部の歯車のアイコン→ツールボックスにモデルを追加
* スタイルの登録 パネルに追加されたモデルを右クリック→出力のためのレンダリングスタイルを編集→QGISスタイルファイル（.qml）を割り当てる。
* モデルの実行 パネルに追加されたモデルをダブルクリック
# 登録ファイルの説明
## PhotoView_Inport.model3
* QGISのモデル。ジオタグ付きの写真のフォルダを指定して、photoviewスタイル用のデータ（レイヤ）を作成します。
### プロセッシング実行の前準備
* プロセッシングツールボックスに登録し、「出力のためのレンダリングスタイルを編集」に「PhotoView.qml」を設定する。
* プロジェクトのCRSを投影座標に設定する。
### プロセッシングの処理内容
* 「ジオタグ（位置情報）付きの写真」でレイヤ作成
* 「レイヤの再投影」でプロジェクトCRSに変換
* 「フィールド計算機」でプロジェクトフォルダからの相対パス"relpath"作成。写真がプロジェクトフォルダの下位ではない場合はnull。
* 「属性のリファクタリング」でinvisible（真偽値）,label（STRING）フィールド追加
## PhotoView_Parameter.model3
* QGISのモデル。photoviewスタイルのパラメータ（プロジェクト変数）を設定・更新します。
* アイコンの色、写真の数などを設定します。
* qfieldでは、デスクトップで設定したプロジェクト変数を確認・変更できませんが、値そのものは有効です。
## PhotoView.qml
* QGISのスタイルファイル。
* プロジェクトCRSとレイヤのCRSは同じ投影座標にする必要があります。
* 参照する写真ファイルは、"photo"(絶対パス)がある場合は、それを、ない場合は プロジェクトフォルダ/"relpath" を使用します。
* invisible フィールドがtrueの場合、写真を表示せず、撮影位置はグレー表示となる。invisible フィールドがない場合、及びfalseの場合は写真を表示します。
* label フィールドに値がある場合ラベルとして使用、ない場合filenameフィールドを使用します。
* qfieldではボタンの幅分、左右の余白を大きくしています。
# 動作確認
* QGIS3.28.2 / Windows10
# 既知の問題
* QGIS3.16では縦撮りの写真が横になる。QGIS3.22以降では縦になるがアンカー位置が写真の中間部になる（期待されるのは写真上部中央）
* 地図の回転には対応しない
