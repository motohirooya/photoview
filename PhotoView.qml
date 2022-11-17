<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis labelsEnabled="1" version="3.28.0-Firenze" styleCategories="Symbology|Labeling|Fields|Forms|Actions|AttributeTable">
  <renderer-v2 type="RuleRenderer" symbollevels="0" forceraster="0" enableorderby="0" referencescale="-1">
    <rules key="{4c83798d-3edf-4754-852c-330910c581ec}">
      <rule filter="/*&#xd;&#xa;写真表示地物かの条件判定　シンボロジ、ラベル共通&#xd;&#xa;*/&#xd;&#xa;with_variable('para',map(&#xd;&#xa; 'Number',  to_int( coalesce(@PhotoView_Number , 8) *if( @qgis_platform&lt;>'mobile',1,if( @map_extent_width > @map_extent_height ,1, @map_extent_width / @map_extent_height ))) ,&#xd;&#xa; 'TopMargin', to_real(coalesce(@PhotoView_TopMargin ,6.0)+if( @qgis_platform='mobile',3,0))*@map_scale/1000,&#xd;&#xa; 'SideMargin', if( @qgis_platform='mobile',9,1) * @map_scale / 1000,&#xd;&#xa; 'PhotoByGap', 15.0),&#xd;&#xa;with_variable('Gap',(@map_extent_width - @para['SideMargin']*2) /((@para['PhotoByGap']+1)*@para['Number']-1),&#xd;&#xa;with_variable('Extent',&#xd;&#xa;&#x9; intersection(  @map_extent , translate(  @map_extent ,0,-@para['PhotoByGap']*@Gap*0.800-@para['TopMargin'])),&#xd;&#xa;CASE &#xd;&#xa;WHEN  @map_rotation &lt;> 0 THEN false&#xd;&#xa;WHEN  attribute(  'invisible' ) THEN false&#xd;&#xa;WHEN  not within(   $geometry , @Extent )  THEN false&#xd;&#xa;ELSE&#xd;&#xa;with_variable('DistRank', array_find(&#xd;&#xa;&#x9; array_foreach(&#xd;&#xa;&#x9;array_sort( &#xd;&#xa;&#x9;&#x9;array_agg(  array(  distance(  @map_extent_center , $geometry ),$id  ) ,filter:=if( attribute(  'invisible' ),false,true) and within(   $geometry , @Extent ))&#xd;&#xa;&#x9;),&#xd;&#xa;&#x9;@element[1])&#xd;&#xa;&#x9;,$id),&#xd;&#xa;@DistRank&lt;@para['Number'])&#xd;&#xa;END&#xd;&#xa;)))&#xd;&#xa;&#xd;&#xa;" key="{580b1a51-0fff-4616-b191-d07f43f2f41a}" symbol="0" label="PHOTO"/>
      <rule filter="ELSE" key="{11dde42b-66f3-4248-b456-51b3af11524f}" symbol="1" label="far"/>
      <rule filter="/*&#xd;&#xa;invisible フィールドがtrueの場合は写真表示から除外、アイコンはグレー&#xd;&#xa;*/&#xd;&#xa;  attribute( 'invisible' )&#xd;&#xa;&#xd;&#xa;/*&#xd;&#xa;photoview履歴・メモ,motohirooya&#xd;&#xa;2022/2/23　動くものができる&#xd;&#xa;2022/3/2&#xd;&#xa;・引き出し線を曲線（smooth）、引き出し線の起点をラスタ画像マーカと同じに。このため、@LEADER変数が不要に&#xd;&#xa;・invisibleフィールド（真偽値）を導入、値がtrueの場合は写真を非表示、それ以外（false,nll,フィールドが無い場合）は写真を表示）&#xd;&#xa;・photoview_inportモデル作成。invisibleフィールドの追加は属性リファクタリング（フィールド演算、フィールド追加では、真偽値が選べない。バージョンアップで「ジオタグ（位置情報）付きの写真」の出力がかわることに注意）&#xd;&#xa;・撮影位置を矢印から扇に変更&#xd;&#xa;2022/3/13 色の調整、コメントの記載&#xd;&#xa;2022/9/14 ラベルが衝突して表示されないことがあったので、プロジェクト変数に全角文字に対する半角文字の幅のパラメータを追加し、ラベルサイズの計算を行うよう変更（以前は0.66・・・の固定値を使用していた）&#xd;&#xa;ラベルサイズのプロジェクト変数を削除し、写真の上の余白-1mmを最大ラベルサイズとした。&#xd;&#xa;表示範囲外の地物は写真を表示しない条件を追加&#xd;&#xa;2022/9/19 写真と引き出し線が重ならないよう、写真を表示する上部はフィルタ範囲から除外（写真の縦横比は0.800を仮定）&#xd;&#xa;2022/9/23 label フィールド追加、値がある場合はラベルのフィールドとして使用&#xd;&#xa;2022/9/30 PhotoView_SingleByteCaracterWidth の既定値を0.8→0.7&#xd;&#xa;中心点との距離が同一の場合、順序がおかしくなる可能性があったのを修正&#xd;&#xa;labelフィールドがない場合、文字サイズの計算がおかしかったのを修正&#xd;&#xa;2022/10/24 プロジェクト変数未設定時の文字サイズ修正、方位角nullの場合は●を表示、写真選択基準の距離の起点を画面中心から対象範囲（@Extent）に&#xd;&#xa;2022/11/8&#xd;&#xa;シンボルとラベルの色を変数PhotoView_Colorに設定。Qfield用の色々調整。photoフィールドがない場合はrelpathフィールドを参照するように&#xd;&#xa;2022/11/17 with_variableをマップ型オブジェクトでまとめた。写真選択基準の距離の起点を画面中心に戻した。&#xd;&#xa;&#xd;&#xa;既知の問題&#xd;&#xa;・QGIS3.16では縦撮りの写真が横になる。QGIS3.22では縦になるがアンカー位置が写真の中間部になる（期待されるのは写真上部中央）&#xd;&#xa;・地図の回転には対応しない&#xd;&#xa;*/" key="{3881f3a2-408f-4e64-84f6-d42475562fae}" symbol="2" label="invisible"/>
    </rules>
    <symbols>
      <symbol type="marker" alpha="0.6" clip_to_extent="1" is_animated="0" frame_rate="10" force_rhr="0" name="0">
        <data_defined_properties>
          <Option type="Map">
            <Option type="QString" value="" name="name"/>
            <Option name="properties"/>
            <Option type="QString" value="collection" name="type"/>
          </Option>
        </data_defined_properties>
        <layer enabled="1" pass="6" class="GeometryGenerator" locked="0">
          <Option type="Map">
            <Option type="QString" value="Line" name="SymbolType"/>
            <Option type="QString" value="/*&#xd;&#xa;写真と撮影位置を結ぶライン 写真のアンカー位置を@piとし、一旦下に下げてから撮影位置と結ぶ&#xd;&#xa;*/&#xd;&#xa;&#xd;&#xa;with_variable('para',map(&#xd;&#xa; 'Number',  to_int( coalesce(@PhotoView_Number , 8) *if( @qgis_platform&lt;>'mobile',1,if( @map_extent_width > @map_extent_height ,1, @map_extent_width / @map_extent_height ))) ,&#xd;&#xa; 'TopMargin', to_real(coalesce(@PhotoView_TopMargin ,6.0)+if( @qgis_platform='mobile',3,0))*@map_scale/1000,&#xd;&#xa; 'SideMargin', if( @qgis_platform='mobile',9,1) * @map_scale / 1000,&#xd;&#xa; 'PhotoByGap', 15.0),&#xd;&#xa;with_variable('Gap',(@map_extent_width - @para['SideMargin']*2) /((@para['PhotoByGap']+1)*@para['Number']-1),&#xd;&#xa;with_variable('Extent',intersection(  @map_extent , translate(  @map_extent ,0,-@para['PhotoByGap']*@Gap*0.800-@para['TopMargin'])),&#xd;&#xa;with_variable('i',  --左から何番目か&#xd;&#xa; array_find(&#xd;&#xa;  array_foreach(&#xd;&#xa;    array_sort(&#xd;&#xa;&#x9; array_foreach( &#xd;&#xa;  &#x9;  array_slice(&#xd;&#xa;       array_sort( &#xd;&#xa;        array_agg(  array(  distance(  @map_extent_center , $geometry ),$id ,$x ) ,filter:=if( attribute(  'invisible' ),false,true) and within(   $geometry , @Extent ))&#xd;&#xa;        )&#xd;&#xa;      ,0,@para['Number']-1)&#xd;&#xa;&#x9;, array_reverse(@element))&#xd;&#xa;    )&#xd;&#xa;  ,@element[1])&#xd;&#xa; ,$id),&#x9;&#x9;-- i の定義終わり&#xd;&#xa; with_variable('p0',translate(@map_extent_center,@para['SideMargin']+(@para['PhotoByGap']/2)*@Gap-@map_extent_width/2,&#xd;&#xa;  @map_extent_height/2-@para['TopMargin']),&#xd;&#xa;with_variable('pi',&#xd;&#xa;&#x9;translate(@p0,(1+@para['PhotoByGap'])*@Gap*@i,0),&#xd;&#xa;  smooth( make_line( @pi, make_point(x(@pi), (y(@pi)+y($geometry))/2 ) , $geometry  ) ,5 ) &#xd;&#xa;))))))&#xd;&#xa;" name="geometryModifier"/>
            <Option type="QString" value="MapUnit" name="units"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" value="" name="name"/>
              <Option name="properties"/>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
          <symbol type="line" alpha="1" clip_to_extent="1" is_animated="0" frame_rate="10" force_rhr="0" name="@0@0">
            <data_defined_properties>
              <Option type="Map">
                <Option type="QString" value="" name="name"/>
                <Option name="properties"/>
                <Option type="QString" value="collection" name="type"/>
              </Option>
            </data_defined_properties>
            <layer enabled="1" pass="0" class="SimpleLine" locked="0">
              <Option type="Map">
                <Option type="QString" value="0" name="align_dash_pattern"/>
                <Option type="QString" value="square" name="capstyle"/>
                <Option type="QString" value="5;2" name="customdash"/>
                <Option type="QString" value="3x:0,0,0,0,0,0" name="customdash_map_unit_scale"/>
                <Option type="QString" value="MM" name="customdash_unit"/>
                <Option type="QString" value="0" name="dash_pattern_offset"/>
                <Option type="QString" value="3x:0,0,0,0,0,0" name="dash_pattern_offset_map_unit_scale"/>
                <Option type="QString" value="MM" name="dash_pattern_offset_unit"/>
                <Option type="QString" value="0" name="draw_inside_polygon"/>
                <Option type="QString" value="bevel" name="joinstyle"/>
                <Option type="QString" value="15,245,245,255" name="line_color"/>
                <Option type="QString" value="solid" name="line_style"/>
                <Option type="QString" value="0.2" name="line_width"/>
                <Option type="QString" value="MM" name="line_width_unit"/>
                <Option type="QString" value="0" name="offset"/>
                <Option type="QString" value="3x:0,0,0,0,0,0" name="offset_map_unit_scale"/>
                <Option type="QString" value="MM" name="offset_unit"/>
                <Option type="QString" value="0" name="ring_filter"/>
                <Option type="QString" value="0" name="trim_distance_end"/>
                <Option type="QString" value="3x:0,0,0,0,0,0" name="trim_distance_end_map_unit_scale"/>
                <Option type="QString" value="MM" name="trim_distance_end_unit"/>
                <Option type="QString" value="0" name="trim_distance_start"/>
                <Option type="QString" value="3x:0,0,0,0,0,0" name="trim_distance_start_map_unit_scale"/>
                <Option type="QString" value="MM" name="trim_distance_start_unit"/>
                <Option type="QString" value="0" name="tweak_dash_pattern_on_corners"/>
                <Option type="QString" value="0" name="use_custom_dash"/>
                <Option type="QString" value="3x:0,0,0,0,0,0" name="width_map_unit_scale"/>
              </Option>
              <data_defined_properties>
                <Option type="Map">
                  <Option type="QString" value="" name="name"/>
                  <Option type="Map" name="properties">
                    <Option type="Map" name="outlineColor">
                      <Option type="bool" value="true" name="active"/>
                      <Option type="QString" value="@PhotoView_Color" name="expression"/>
                      <Option type="int" value="3" name="type"/>
                    </Option>
                  </Option>
                  <Option type="QString" value="collection" name="type"/>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </layer>
        <layer enabled="1" pass="4" class="SimpleMarker" locked="0">
          <Option type="Map">
            <Option type="QString" value="0" name="angle"/>
            <Option type="QString" value="square" name="cap_style"/>
            <Option type="QString" value="15,245,245,255" name="color"/>
            <Option type="QString" value="1" name="horizontal_anchor_point"/>
            <Option type="QString" value="bevel" name="joinstyle"/>
            <Option type="QString" value="quarter_circle" name="name"/>
            <Option type="QString" value="0,0" name="offset"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="offset_map_unit_scale"/>
            <Option type="QString" value="MM" name="offset_unit"/>
            <Option type="QString" value="35,35,35,255" name="outline_color"/>
            <Option type="QString" value="solid" name="outline_style"/>
            <Option type="QString" value="0.2" name="outline_width"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="outline_width_map_unit_scale"/>
            <Option type="QString" value="MM" name="outline_width_unit"/>
            <Option type="QString" value="diameter" name="scale_method"/>
            <Option type="QString" value="5" name="size"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="size_map_unit_scale"/>
            <Option type="QString" value="MM" name="size_unit"/>
            <Option type="QString" value="1" name="vertical_anchor_point"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" value="" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="angle">
                  <Option type="bool" value="true" name="active"/>
                  <Option type="QString" value="&quot;direction&quot; + 45" name="expression"/>
                  <Option type="int" value="3" name="type"/>
                </Option>
                <Option type="Map" name="enabled">
                  <Option type="bool" value="true" name="active"/>
                  <Option type="QString" value="&quot;direction&quot; is not null" name="expression"/>
                  <Option type="int" value="3" name="type"/>
                </Option>
                <Option type="Map" name="fillColor">
                  <Option type="bool" value="true" name="active"/>
                  <Option type="QString" value="@PhotoView_Color" name="expression"/>
                  <Option type="int" value="3" name="type"/>
                </Option>
              </Option>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer enabled="1" pass="0" class="SimpleMarker" locked="0">
          <Option type="Map">
            <Option type="QString" value="0" name="angle"/>
            <Option type="QString" value="square" name="cap_style"/>
            <Option type="QString" value="15,245,245,255" name="color"/>
            <Option type="QString" value="1" name="horizontal_anchor_point"/>
            <Option type="QString" value="bevel" name="joinstyle"/>
            <Option type="QString" value="circle" name="name"/>
            <Option type="QString" value="0,0" name="offset"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="offset_map_unit_scale"/>
            <Option type="QString" value="MM" name="offset_unit"/>
            <Option type="QString" value="35,35,35,255" name="outline_color"/>
            <Option type="QString" value="solid" name="outline_style"/>
            <Option type="QString" value="0.2" name="outline_width"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="outline_width_map_unit_scale"/>
            <Option type="QString" value="MM" name="outline_width_unit"/>
            <Option type="QString" value="diameter" name="scale_method"/>
            <Option type="QString" value="2" name="size"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="size_map_unit_scale"/>
            <Option type="QString" value="MM" name="size_unit"/>
            <Option type="QString" value="1" name="vertical_anchor_point"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" value="" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="angle">
                  <Option type="bool" value="false" name="active"/>
                  <Option type="int" value="1" name="type"/>
                  <Option type="QString" value="" name="val"/>
                </Option>
                <Option type="Map" name="enabled">
                  <Option type="bool" value="true" name="active"/>
                  <Option type="QString" value="&quot;direction&quot; is null" name="expression"/>
                  <Option type="int" value="3" name="type"/>
                </Option>
                <Option type="Map" name="fillColor">
                  <Option type="bool" value="true" name="active"/>
                  <Option type="QString" value="@PhotoView_Color" name="expression"/>
                  <Option type="int" value="3" name="type"/>
                </Option>
              </Option>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer enabled="1" pass="5" class="SimpleMarker" locked="0">
          <Option type="Map">
            <Option type="QString" value="0" name="angle"/>
            <Option type="QString" value="square" name="cap_style"/>
            <Option type="QString" value="0,0,0,255" name="color"/>
            <Option type="QString" value="1" name="horizontal_anchor_point"/>
            <Option type="QString" value="bevel" name="joinstyle"/>
            <Option type="QString" value="circle" name="name"/>
            <Option type="QString" value="0,0" name="offset"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="offset_map_unit_scale"/>
            <Option type="QString" value="MM" name="offset_unit"/>
            <Option type="QString" value="35,35,35,255" name="outline_color"/>
            <Option type="QString" value="no" name="outline_style"/>
            <Option type="QString" value="0" name="outline_width"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="outline_width_map_unit_scale"/>
            <Option type="QString" value="MM" name="outline_width_unit"/>
            <Option type="QString" value="diameter" name="scale_method"/>
            <Option type="QString" value="0.6" name="size"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="size_map_unit_scale"/>
            <Option type="QString" value="MM" name="size_unit"/>
            <Option type="QString" value="1" name="vertical_anchor_point"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" value="" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="angle">
                  <Option type="bool" value="false" name="active"/>
                  <Option type="QString" value="" name="expression"/>
                  <Option type="int" value="3" name="type"/>
                </Option>
              </Option>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer enabled="1" pass="7" class="GeometryGenerator" locked="0">
          <Option type="Map">
            <Option type="QString" value="Marker" name="SymbolType"/>
            <Option type="QString" value="/*&#xd;&#xa;ラスタ画像マーカーのアンカー位置、ラベルのアンカー位置　共通&#xd;&#xa;*/&#xd;&#xa;with_variable('para',map(&#xd;&#xa; 'Number',  to_int( coalesce(@PhotoView_Number , 8) *if( @qgis_platform&lt;>'mobile',1,if( @map_extent_width > @map_extent_height ,1, @map_extent_width / @map_extent_height ))) ,&#xd;&#xa; 'TopMargin', to_real(coalesce(@PhotoView_TopMargin ,6.0)+if( @qgis_platform='mobile',3,0))*@map_scale/1000,&#xd;&#xa; 'SideMargin', if( @qgis_platform='mobile',9,1) * @map_scale / 1000,&#xd;&#xa; 'PhotoByGap', 15.0),&#xd;&#xa;with_variable('Gap',(@map_extent_width - @para['SideMargin']*2) /((@para['PhotoByGap']+1)*@para['Number']-1),&#xd;&#xa;with_variable('Extent',intersection(  @map_extent , translate(  @map_extent ,0,-@para['PhotoByGap']*@Gap*0.800-@para['TopMargin'])),&#xd;&#xa;with_variable('i',  --左から何番目か&#xd;&#xa; array_find(&#xd;&#xa;  array_foreach(&#xd;&#xa;    array_sort(&#xd;&#xa;&#x9; array_foreach( &#xd;&#xa;  &#x9;  array_slice(&#xd;&#xa;       array_sort( &#xd;&#xa;        array_agg(  array(  distance(  @map_extent_center , $geometry ),$id ,$x ) ,filter:=if( attribute(  'invisible' ),false,true) and within(   $geometry , @Extent ))&#xd;&#xa;        )&#xd;&#xa;      ,0,@para['Number']-1)&#xd;&#xa;&#x9;, array_reverse(@element))&#xd;&#xa;    )&#xd;&#xa;  ,@element[1])&#xd;&#xa; ,$id),&#x9;&#x9;-- i の定義終わり&#xd;&#xa; with_variable('p0',translate(@map_extent_center,@para['SideMargin']+(@para['PhotoByGap']/2)*@Gap-@map_extent_width/2,&#xd;&#xa;  @map_extent_height/2-@para['TopMargin']),&#xd;&#xa; translate(@p0,(1+@para['PhotoByGap'])*@Gap*@i,0)&#xd;&#xa;)))))&#xd;&#xa;" name="geometryModifier"/>
            <Option type="QString" value="MapUnit" name="units"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" value="" name="name"/>
              <Option name="properties"/>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
          <symbol type="marker" alpha="1" clip_to_extent="1" is_animated="0" frame_rate="10" force_rhr="0" name="@0@4">
            <data_defined_properties>
              <Option type="Map">
                <Option type="QString" value="" name="name"/>
                <Option name="properties"/>
                <Option type="QString" value="collection" name="type"/>
              </Option>
            </data_defined_properties>
            <layer enabled="1" pass="0" class="RasterMarker" locked="0">
              <Option type="Map">
                <Option type="QString" value="1" name="alpha"/>
                <Option type="QString" value="0" name="angle"/>
                <Option type="QString" value="0" name="fixedAspectRatio"/>
                <Option type="QString" value="1" name="horizontal_anchor_point"/>
                <Option type="QString" value="" name="imageFile"/>
                <Option type="QString" value="0,0" name="offset"/>
                <Option type="QString" value="3x:0,0,0,0,0,0" name="offset_map_unit_scale"/>
                <Option type="QString" value="MM" name="offset_unit"/>
                <Option type="QString" value="diameter" name="scale_method"/>
                <Option type="QString" value="2" name="size"/>
                <Option type="QString" value="3x:0,0,0,0,0,0" name="size_map_unit_scale"/>
                <Option type="QString" value="MapUnit" name="size_unit"/>
                <Option type="QString" value="0" name="vertical_anchor_point"/>
              </Option>
              <effect type="effectStack" enabled="1">
                <effect type="dropShadow">
                  <Option type="Map">
                    <Option type="QString" value="13" name="blend_mode"/>
                    <Option type="QString" value="2.645" name="blur_level"/>
                    <Option type="QString" value="MM" name="blur_unit"/>
                    <Option type="QString" value="3x:0,0,0,0,0,0" name="blur_unit_scale"/>
                    <Option type="QString" value="0,0,0,255" name="color"/>
                    <Option type="QString" value="2" name="draw_mode"/>
                    <Option type="QString" value="0" name="enabled"/>
                    <Option type="QString" value="135" name="offset_angle"/>
                    <Option type="QString" value="2" name="offset_distance"/>
                    <Option type="QString" value="MM" name="offset_unit"/>
                    <Option type="QString" value="3x:0,0,0,0,0,0" name="offset_unit_scale"/>
                    <Option type="QString" value="1" name="opacity"/>
                  </Option>
                </effect>
                <effect type="outerGlow">
                  <Option type="Map">
                    <Option type="QString" value="0" name="blend_mode"/>
                    <Option type="QString" value="0.5" name="blur_level"/>
                    <Option type="QString" value="MM" name="blur_unit"/>
                    <Option type="QString" value="3x:0,0,0,0,0,0" name="blur_unit_scale"/>
                    <Option type="QString" value="0,0,255,255" name="color1"/>
                    <Option type="QString" value="0,255,0,255" name="color2"/>
                    <Option type="QString" value="0" name="color_type"/>
                    <Option type="QString" value="ccw" name="direction"/>
                    <Option type="QString" value="0" name="discrete"/>
                    <Option type="QString" value="2" name="draw_mode"/>
                    <Option type="QString" value="1" name="enabled"/>
                    <Option type="QString" value="0.5" name="opacity"/>
                    <Option type="QString" value="gradient" name="rampType"/>
                    <Option type="QString" value="255,255,255,255" name="single_color"/>
                    <Option type="QString" value="rgb" name="spec"/>
                    <Option type="QString" value="1" name="spread"/>
                    <Option type="QString" value="MM" name="spread_unit"/>
                    <Option type="QString" value="3x:0,0,0,0,0,0" name="spread_unit_scale"/>
                  </Option>
                </effect>
                <effect type="drawSource">
                  <Option type="Map">
                    <Option type="QString" value="0" name="blend_mode"/>
                    <Option type="QString" value="2" name="draw_mode"/>
                    <Option type="QString" value="1" name="enabled"/>
                    <Option type="QString" value="1" name="opacity"/>
                  </Option>
                </effect>
                <effect type="innerShadow">
                  <Option type="Map">
                    <Option type="QString" value="13" name="blend_mode"/>
                    <Option type="QString" value="2.645" name="blur_level"/>
                    <Option type="QString" value="MM" name="blur_unit"/>
                    <Option type="QString" value="3x:0,0,0,0,0,0" name="blur_unit_scale"/>
                    <Option type="QString" value="0,0,0,255" name="color"/>
                    <Option type="QString" value="2" name="draw_mode"/>
                    <Option type="QString" value="0" name="enabled"/>
                    <Option type="QString" value="135" name="offset_angle"/>
                    <Option type="QString" value="2" name="offset_distance"/>
                    <Option type="QString" value="MM" name="offset_unit"/>
                    <Option type="QString" value="3x:0,0,0,0,0,0" name="offset_unit_scale"/>
                    <Option type="QString" value="1" name="opacity"/>
                  </Option>
                </effect>
                <effect type="innerGlow">
                  <Option type="Map">
                    <Option type="QString" value="0" name="blend_mode"/>
                    <Option type="QString" value="2.645" name="blur_level"/>
                    <Option type="QString" value="MM" name="blur_unit"/>
                    <Option type="QString" value="3x:0,0,0,0,0,0" name="blur_unit_scale"/>
                    <Option type="QString" value="0,0,255,255" name="color1"/>
                    <Option type="QString" value="0,255,0,255" name="color2"/>
                    <Option type="QString" value="0" name="color_type"/>
                    <Option type="QString" value="ccw" name="direction"/>
                    <Option type="QString" value="0" name="discrete"/>
                    <Option type="QString" value="2" name="draw_mode"/>
                    <Option type="QString" value="0" name="enabled"/>
                    <Option type="QString" value="0.5" name="opacity"/>
                    <Option type="QString" value="gradient" name="rampType"/>
                    <Option type="QString" value="255,255,255,255" name="single_color"/>
                    <Option type="QString" value="rgb" name="spec"/>
                    <Option type="QString" value="2" name="spread"/>
                    <Option type="QString" value="MM" name="spread_unit"/>
                    <Option type="QString" value="3x:0,0,0,0,0,0" name="spread_unit_scale"/>
                  </Option>
                </effect>
              </effect>
              <data_defined_properties>
                <Option type="Map">
                  <Option type="QString" value="" name="name"/>
                  <Option type="Map" name="properties">
                    <Option type="Map" name="name">
                      <Option type="bool" value="true" name="active"/>
                      <Option type="QString" value="replace(&#xd;&#xa; coalesce( attribute( 'photo'),&#xd;&#xa;  file_path( layer_property(  @layer ,'path')) || '/' || attribute('relpath')&#xd;&#xa; )&#xd;&#xa;, '\\','/')" name="expression"/>
                      <Option type="int" value="3" name="type"/>
                    </Option>
                    <Option type="Map" name="width">
                      <Option type="bool" value="true" name="active"/>
                      <Option type="QString" value="with_variable('para',map(&#xd;&#xa; 'Number',  to_int( coalesce(@PhotoView_Number , 8) *if( @qgis_platform&lt;>'mobile',1,if( @map_extent_width > @map_extent_height ,1, @map_extent_width / @map_extent_height ))) ,&#xd;&#xa; 'TopMargin', to_real(coalesce(@PhotoView_TopMargin ,6.0)+if( @qgis_platform='mobile',3,0))*@map_scale/1000,&#xd;&#xa; 'SideMargin', if( @qgis_platform='mobile',9,1) * @map_scale / 1000,&#xd;&#xa; 'PhotoByGap', 15.0),&#xd;&#xa;with_variable('Gap',(@map_extent_width - @para['SideMargin']*2) /((@para['PhotoByGap']+1)*@para['Number']-1),&#xd;&#xa;&#x9;@para['PhotoByGap']*@Gap)&#xd;&#xa;)" name="expression"/>
                      <Option type="int" value="3" name="type"/>
                    </Option>
                  </Option>
                  <Option type="QString" value="collection" name="type"/>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol type="marker" alpha="0.6" clip_to_extent="1" is_animated="0" frame_rate="10" force_rhr="0" name="1">
        <data_defined_properties>
          <Option type="Map">
            <Option type="QString" value="" name="name"/>
            <Option name="properties"/>
            <Option type="QString" value="collection" name="type"/>
          </Option>
        </data_defined_properties>
        <layer enabled="1" pass="2" class="SimpleMarker" locked="0">
          <Option type="Map">
            <Option type="QString" value="0" name="angle"/>
            <Option type="QString" value="square" name="cap_style"/>
            <Option type="QString" value="255,255,255,255" name="color"/>
            <Option type="QString" value="1" name="horizontal_anchor_point"/>
            <Option type="QString" value="bevel" name="joinstyle"/>
            <Option type="QString" value="quarter_circle" name="name"/>
            <Option type="QString" value="0,0" name="offset"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="offset_map_unit_scale"/>
            <Option type="QString" value="MM" name="offset_unit"/>
            <Option type="QString" value="35,35,35,255" name="outline_color"/>
            <Option type="QString" value="solid" name="outline_style"/>
            <Option type="QString" value="0" name="outline_width"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="outline_width_map_unit_scale"/>
            <Option type="QString" value="MM" name="outline_width_unit"/>
            <Option type="QString" value="diameter" name="scale_method"/>
            <Option type="QString" value="5" name="size"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="size_map_unit_scale"/>
            <Option type="QString" value="MM" name="size_unit"/>
            <Option type="QString" value="1" name="vertical_anchor_point"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" value="" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="angle">
                  <Option type="bool" value="true" name="active"/>
                  <Option type="QString" value="&quot;direction&quot; + 45" name="expression"/>
                  <Option type="int" value="3" name="type"/>
                </Option>
                <Option type="Map" name="enabled">
                  <Option type="bool" value="true" name="active"/>
                  <Option type="QString" value="&quot;direction&quot; is not null" name="expression"/>
                  <Option type="int" value="3" name="type"/>
                </Option>
              </Option>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer enabled="1" pass="0" class="SimpleMarker" locked="0">
          <Option type="Map">
            <Option type="QString" value="0" name="angle"/>
            <Option type="QString" value="square" name="cap_style"/>
            <Option type="QString" value="255,255,255,255" name="color"/>
            <Option type="QString" value="1" name="horizontal_anchor_point"/>
            <Option type="QString" value="bevel" name="joinstyle"/>
            <Option type="QString" value="circle" name="name"/>
            <Option type="QString" value="0,0" name="offset"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="offset_map_unit_scale"/>
            <Option type="QString" value="MM" name="offset_unit"/>
            <Option type="QString" value="35,35,35,255" name="outline_color"/>
            <Option type="QString" value="solid" name="outline_style"/>
            <Option type="QString" value="0" name="outline_width"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="outline_width_map_unit_scale"/>
            <Option type="QString" value="MM" name="outline_width_unit"/>
            <Option type="QString" value="diameter" name="scale_method"/>
            <Option type="QString" value="2" name="size"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="size_map_unit_scale"/>
            <Option type="QString" value="MM" name="size_unit"/>
            <Option type="QString" value="1" name="vertical_anchor_point"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" value="" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="angle">
                  <Option type="bool" value="false" name="active"/>
                  <Option type="int" value="1" name="type"/>
                  <Option type="QString" value="" name="val"/>
                </Option>
                <Option type="Map" name="enabled">
                  <Option type="bool" value="true" name="active"/>
                  <Option type="QString" value="&quot;direction&quot; is null" name="expression"/>
                  <Option type="int" value="3" name="type"/>
                </Option>
              </Option>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer enabled="1" pass="3" class="SimpleMarker" locked="0">
          <Option type="Map">
            <Option type="QString" value="0" name="angle"/>
            <Option type="QString" value="square" name="cap_style"/>
            <Option type="QString" value="0,0,0,255" name="color"/>
            <Option type="QString" value="1" name="horizontal_anchor_point"/>
            <Option type="QString" value="bevel" name="joinstyle"/>
            <Option type="QString" value="circle" name="name"/>
            <Option type="QString" value="0,0" name="offset"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="offset_map_unit_scale"/>
            <Option type="QString" value="MM" name="offset_unit"/>
            <Option type="QString" value="35,35,35,255" name="outline_color"/>
            <Option type="QString" value="no" name="outline_style"/>
            <Option type="QString" value="0" name="outline_width"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="outline_width_map_unit_scale"/>
            <Option type="QString" value="MM" name="outline_width_unit"/>
            <Option type="QString" value="diameter" name="scale_method"/>
            <Option type="QString" value="0.75" name="size"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="size_map_unit_scale"/>
            <Option type="QString" value="MM" name="size_unit"/>
            <Option type="QString" value="1" name="vertical_anchor_point"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" value="" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="angle">
                  <Option type="bool" value="false" name="active"/>
                  <Option type="int" value="1" name="type"/>
                  <Option type="QString" value="" name="val"/>
                </Option>
              </Option>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol type="marker" alpha="0.6" clip_to_extent="1" is_animated="0" frame_rate="10" force_rhr="0" name="2">
        <data_defined_properties>
          <Option type="Map">
            <Option type="QString" value="" name="name"/>
            <Option name="properties"/>
            <Option type="QString" value="collection" name="type"/>
          </Option>
        </data_defined_properties>
        <layer enabled="1" pass="0" class="SimpleMarker" locked="0">
          <Option type="Map">
            <Option type="QString" value="0" name="angle"/>
            <Option type="QString" value="square" name="cap_style"/>
            <Option type="QString" value="179,179,179,255" name="color"/>
            <Option type="QString" value="1" name="horizontal_anchor_point"/>
            <Option type="QString" value="bevel" name="joinstyle"/>
            <Option type="QString" value="quarter_circle" name="name"/>
            <Option type="QString" value="0,0" name="offset"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="offset_map_unit_scale"/>
            <Option type="QString" value="MM" name="offset_unit"/>
            <Option type="QString" value="35,35,35,255" name="outline_color"/>
            <Option type="QString" value="solid" name="outline_style"/>
            <Option type="QString" value="0" name="outline_width"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="outline_width_map_unit_scale"/>
            <Option type="QString" value="MM" name="outline_width_unit"/>
            <Option type="QString" value="diameter" name="scale_method"/>
            <Option type="QString" value="5" name="size"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="size_map_unit_scale"/>
            <Option type="QString" value="MM" name="size_unit"/>
            <Option type="QString" value="1" name="vertical_anchor_point"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" value="" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="angle">
                  <Option type="bool" value="true" name="active"/>
                  <Option type="QString" value="&quot;direction&quot; + 45" name="expression"/>
                  <Option type="int" value="3" name="type"/>
                </Option>
                <Option type="Map" name="enabled">
                  <Option type="bool" value="true" name="active"/>
                  <Option type="QString" value="&quot;direction&quot; is not null" name="expression"/>
                  <Option type="int" value="3" name="type"/>
                </Option>
              </Option>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer enabled="1" pass="0" class="SimpleMarker" locked="0">
          <Option type="Map">
            <Option type="QString" value="0" name="angle"/>
            <Option type="QString" value="square" name="cap_style"/>
            <Option type="QString" value="179,179,179,255" name="color"/>
            <Option type="QString" value="1" name="horizontal_anchor_point"/>
            <Option type="QString" value="bevel" name="joinstyle"/>
            <Option type="QString" value="circle" name="name"/>
            <Option type="QString" value="0,0" name="offset"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="offset_map_unit_scale"/>
            <Option type="QString" value="MM" name="offset_unit"/>
            <Option type="QString" value="35,35,35,255" name="outline_color"/>
            <Option type="QString" value="solid" name="outline_style"/>
            <Option type="QString" value="0" name="outline_width"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="outline_width_map_unit_scale"/>
            <Option type="QString" value="MM" name="outline_width_unit"/>
            <Option type="QString" value="diameter" name="scale_method"/>
            <Option type="QString" value="2" name="size"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="size_map_unit_scale"/>
            <Option type="QString" value="MM" name="size_unit"/>
            <Option type="QString" value="1" name="vertical_anchor_point"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" value="" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="angle">
                  <Option type="bool" value="false" name="active"/>
                  <Option type="int" value="1" name="type"/>
                  <Option type="QString" value="" name="val"/>
                </Option>
                <Option type="Map" name="enabled">
                  <Option type="bool" value="true" name="active"/>
                  <Option type="QString" value="&quot;direction&quot; is null" name="expression"/>
                  <Option type="int" value="3" name="type"/>
                </Option>
              </Option>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer enabled="1" pass="1" class="SimpleMarker" locked="0">
          <Option type="Map">
            <Option type="QString" value="0" name="angle"/>
            <Option type="QString" value="square" name="cap_style"/>
            <Option type="QString" value="0,0,0,255" name="color"/>
            <Option type="QString" value="1" name="horizontal_anchor_point"/>
            <Option type="QString" value="bevel" name="joinstyle"/>
            <Option type="QString" value="circle" name="name"/>
            <Option type="QString" value="0,0" name="offset"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="offset_map_unit_scale"/>
            <Option type="QString" value="MM" name="offset_unit"/>
            <Option type="QString" value="35,35,35,255" name="outline_color"/>
            <Option type="QString" value="no" name="outline_style"/>
            <Option type="QString" value="0" name="outline_width"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="outline_width_map_unit_scale"/>
            <Option type="QString" value="MM" name="outline_width_unit"/>
            <Option type="QString" value="diameter" name="scale_method"/>
            <Option type="QString" value="0.75" name="size"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="size_map_unit_scale"/>
            <Option type="QString" value="MM" name="size_unit"/>
            <Option type="QString" value="1" name="vertical_anchor_point"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" value="" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="angle">
                  <Option type="bool" value="false" name="active"/>
                  <Option type="int" value="1" name="type"/>
                  <Option type="QString" value="" name="val"/>
                </Option>
              </Option>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </symbols>
  </renderer-v2>
  <labeling type="rule-based">
    <rules key="{820f72f0-8d47-4b69-ba0c-bda324f46716}">
      <rule filter="/*&#xd;&#xa;写真表示地物かの条件判定　シンボロジ、ラベル共通&#xd;&#xa;*/&#xd;&#xa;with_variable('para',map(&#xd;&#xa; 'Number',  to_int( coalesce(@PhotoView_Number , 8) *if( @qgis_platform&lt;>'mobile',1,if( @map_extent_width > @map_extent_height ,1, @map_extent_width / @map_extent_height ))) ,&#xd;&#xa; 'TopMargin', to_real(coalesce(@PhotoView_TopMargin ,6.0)+if( @qgis_platform='mobile',3,0))*@map_scale/1000,&#xd;&#xa; 'SideMargin', if( @qgis_platform='mobile',9,1) * @map_scale / 1000,&#xd;&#xa; 'PhotoByGap', 15.0),&#xd;&#xa;with_variable('Gap',(@map_extent_width - @para['SideMargin']*2) /((@para['PhotoByGap']+1)*@para['Number']-1),&#xd;&#xa;with_variable('Extent',&#xd;&#xa;&#x9; intersection(  @map_extent , translate(  @map_extent ,0,-@para['PhotoByGap']*@Gap*0.800-@para['TopMargin'])),&#xd;&#xa;CASE &#xd;&#xa;WHEN  @map_rotation &lt;> 0 THEN false&#xd;&#xa;WHEN  attribute(  'invisible' ) THEN false&#xd;&#xa;WHEN  not within(   $geometry , @Extent )  THEN false&#xd;&#xa;ELSE&#xd;&#xa;with_variable('DistRank', array_find(&#xd;&#xa;&#x9; array_foreach(&#xd;&#xa;&#x9;array_sort( &#xd;&#xa;&#x9;&#x9;array_agg(  array(  distance(  @map_extent_center , $geometry ),$id  ) ,filter:=if( attribute(  'invisible' ),false,true) and within(   $geometry , @Extent ))&#xd;&#xa;&#x9;),&#xd;&#xa;&#x9;@element[1])&#xd;&#xa;&#x9;,$id),&#xd;&#xa;@DistRank&lt;@para['Number'])&#xd;&#xa;END&#xd;&#xa;)))" key="{fe70907b-0938-4491-a9aa-9c578e9fcb6b}" description="Photo">
        <settings calloutType="simple">
          <text-style multilineHeightUnit="Percentage" textOpacity="1" fontLetterSpacing="0" allowHtml="0" fontUnderline="0" fontWordSpacing="0" blendMode="0" textColor="0,0,255,255" fontFamily="Arial" fontSizeMapUnitScale="3x:0,0,0,0,0,0" legendString="Aa" useSubstitutions="0" fontWeight="50" namedStyle="Regular" multilineHeight="1" forcedItalic="0" textOrientation="horizontal" fontItalic="0" fontKerning="1" fontSize="10" isExpression="1" previewBkgrdColor="255,255,255,255" capitalization="0" fieldName="coalesce(  attribute( 'label') , attribute('filename') ) " fontSizeUnit="MapUnit" fontStrikeout="0" forcedBold="0">
            <families/>
            <text-buffer bufferBlendMode="0" bufferJoinStyle="128" bufferOpacity="1" bufferNoFill="1" bufferSizeUnits="MM" bufferSizeMapUnitScale="3x:0,0,0,0,0,0" bufferDraw="1" bufferSize="0.59999999999999998" bufferColor="250,250,250,255"/>
            <text-mask maskSizeUnits="MM" maskSize="0" maskOpacity="1" maskType="0" maskJoinStyle="128" maskedSymbolLayers="" maskSizeMapUnitScale="3x:0,0,0,0,0,0" maskEnabled="0"/>
            <background shapeDraw="0" shapeRadiiX="0" shapeSizeX="0" shapeType="0" shapeOffsetMapUnitScale="3x:0,0,0,0,0,0" shapeRadiiMapUnitScale="3x:0,0,0,0,0,0" shapeFillColor="255,255,255,255" shapeBorderWidthMapUnitScale="3x:0,0,0,0,0,0" shapeBorderWidthUnit="Point" shapeSizeMapUnitScale="3x:0,0,0,0,0,0" shapeRadiiUnit="Point" shapeRotationType="0" shapeOpacity="1" shapeSizeY="0" shapeOffsetUnit="Point" shapeSizeType="0" shapeJoinStyle="64" shapeRadiiY="0" shapeBorderWidth="0" shapeRotation="0" shapeOffsetX="0" shapeSizeUnit="Point" shapeSVGFile="" shapeOffsetY="0" shapeBlendMode="0" shapeBorderColor="128,128,128,255">
              <symbol type="marker" alpha="1" clip_to_extent="1" is_animated="0" frame_rate="10" force_rhr="0" name="markerSymbol">
                <data_defined_properties>
                  <Option type="Map">
                    <Option type="QString" value="" name="name"/>
                    <Option name="properties"/>
                    <Option type="QString" value="collection" name="type"/>
                  </Option>
                </data_defined_properties>
                <layer enabled="1" pass="0" class="SimpleMarker" locked="0">
                  <Option type="Map">
                    <Option type="QString" value="0" name="angle"/>
                    <Option type="QString" value="square" name="cap_style"/>
                    <Option type="QString" value="243,166,178,255" name="color"/>
                    <Option type="QString" value="1" name="horizontal_anchor_point"/>
                    <Option type="QString" value="bevel" name="joinstyle"/>
                    <Option type="QString" value="circle" name="name"/>
                    <Option type="QString" value="0,0" name="offset"/>
                    <Option type="QString" value="3x:0,0,0,0,0,0" name="offset_map_unit_scale"/>
                    <Option type="QString" value="MM" name="offset_unit"/>
                    <Option type="QString" value="35,35,35,255" name="outline_color"/>
                    <Option type="QString" value="solid" name="outline_style"/>
                    <Option type="QString" value="0" name="outline_width"/>
                    <Option type="QString" value="3x:0,0,0,0,0,0" name="outline_width_map_unit_scale"/>
                    <Option type="QString" value="MM" name="outline_width_unit"/>
                    <Option type="QString" value="diameter" name="scale_method"/>
                    <Option type="QString" value="2" name="size"/>
                    <Option type="QString" value="3x:0,0,0,0,0,0" name="size_map_unit_scale"/>
                    <Option type="QString" value="MM" name="size_unit"/>
                    <Option type="QString" value="1" name="vertical_anchor_point"/>
                  </Option>
                  <data_defined_properties>
                    <Option type="Map">
                      <Option type="QString" value="" name="name"/>
                      <Option name="properties"/>
                      <Option type="QString" value="collection" name="type"/>
                    </Option>
                  </data_defined_properties>
                </layer>
              </symbol>
              <symbol type="fill" alpha="1" clip_to_extent="1" is_animated="0" frame_rate="10" force_rhr="0" name="fillSymbol">
                <data_defined_properties>
                  <Option type="Map">
                    <Option type="QString" value="" name="name"/>
                    <Option name="properties"/>
                    <Option type="QString" value="collection" name="type"/>
                  </Option>
                </data_defined_properties>
                <layer enabled="1" pass="0" class="SimpleFill" locked="0">
                  <Option type="Map">
                    <Option type="QString" value="3x:0,0,0,0,0,0" name="border_width_map_unit_scale"/>
                    <Option type="QString" value="255,255,255,255" name="color"/>
                    <Option type="QString" value="bevel" name="joinstyle"/>
                    <Option type="QString" value="0,0" name="offset"/>
                    <Option type="QString" value="3x:0,0,0,0,0,0" name="offset_map_unit_scale"/>
                    <Option type="QString" value="MM" name="offset_unit"/>
                    <Option type="QString" value="128,128,128,255" name="outline_color"/>
                    <Option type="QString" value="no" name="outline_style"/>
                    <Option type="QString" value="0" name="outline_width"/>
                    <Option type="QString" value="Point" name="outline_width_unit"/>
                    <Option type="QString" value="solid" name="style"/>
                  </Option>
                  <data_defined_properties>
                    <Option type="Map">
                      <Option type="QString" value="" name="name"/>
                      <Option name="properties"/>
                      <Option type="QString" value="collection" name="type"/>
                    </Option>
                  </data_defined_properties>
                </layer>
              </symbol>
            </background>
            <shadow shadowRadiusMapUnitScale="3x:0,0,0,0,0,0" shadowRadiusAlphaOnly="0" shadowRadius="1.5" shadowDraw="0" shadowColor="0,0,0,255" shadowOffsetGlobal="1" shadowOffsetDist="1" shadowScale="100" shadowUnder="0" shadowOffsetAngle="135" shadowOffsetUnit="MM" shadowOffsetMapUnitScale="3x:0,0,0,0,0,0" shadowBlendMode="6" shadowRadiusUnit="MM" shadowOpacity="0.69999999999999996"/>
            <dd_properties>
              <Option type="Map">
                <Option type="QString" value="" name="name"/>
                <Option name="properties"/>
                <Option type="QString" value="collection" name="type"/>
              </Option>
            </dd_properties>
            <substitutions/>
          </text-style>
          <text-format useMaxLineLengthForAutoWrap="1" multilineAlign="3" leftDirectionSymbol="&lt;" decimals="3" autoWrapLength="0" placeDirectionSymbol="0" wrapChar="" plussign="0" rightDirectionSymbol=">" reverseDirectionSymbol="0" formatNumbers="0" addDirectionSymbol="0"/>
          <placement geometryGeneratorType="PointGeometry" fitInPolygonOnly="0" geometryGeneratorEnabled="1" labelOffsetMapUnitScale="3x:0,0,0,0,0,0" yOffset="0" distUnits="MM" lineAnchorClipping="0" priority="5" overrunDistanceMapUnitScale="3x:0,0,0,0,0,0" allowDegraded="0" xOffset="0" geometryGenerator="/*&#xd;&#xa;ラスタ画像マーカーのアンカー位置、ラベルのアンカー位置　共通&#xd;&#xa;*/&#xd;&#xa;with_variable('para',map(&#xd;&#xa; 'Number',  to_int( coalesce(@PhotoView_Number , 8) *if( @qgis_platform&lt;>'mobile',1,if( @map_extent_width > @map_extent_height ,1, @map_extent_width / @map_extent_height ))) ,&#xd;&#xa; 'TopMargin', to_real(coalesce(@PhotoView_TopMargin ,6.0)+if( @qgis_platform='mobile',3,0))*@map_scale/1000,&#xd;&#xa; 'SideMargin', if( @qgis_platform='mobile',9,1) * @map_scale / 1000,&#xd;&#xa; 'PhotoByGap', 15.0),&#xd;&#xa;with_variable('Gap',(@map_extent_width - @para['SideMargin']*2) /((@para['PhotoByGap']+1)*@para['Number']-1),&#xd;&#xa;with_variable('Extent',intersection(  @map_extent , translate(  @map_extent ,0,-@para['PhotoByGap']*@Gap*0.800-@para['TopMargin'])),&#xd;&#xa;with_variable('i',  --左から何番目か&#xd;&#xa; array_find(&#xd;&#xa;  array_foreach(&#xd;&#xa;    array_sort(&#xd;&#xa;&#x9; array_foreach( &#xd;&#xa;  &#x9;  array_slice(&#xd;&#xa;       array_sort( &#xd;&#xa;        array_agg(  array(  distance(  @map_extent_center , $geometry ),$id ,$x ) ,filter:=if( attribute(  'invisible' ),false,true) and within(   $geometry , @Extent ))&#xd;&#xa;        )&#xd;&#xa;      ,0,@para['Number']-1)&#xd;&#xa;&#x9;, array_reverse(@element))&#xd;&#xa;    )&#xd;&#xa;  ,@element[1])&#xd;&#xa; ,$id),&#x9;&#x9;-- i の定義終わり&#xd;&#xa; with_variable('p0',translate(@map_extent_center,@para['SideMargin']+(@para['PhotoByGap']/2)*@Gap-@map_extent_width/2,&#xd;&#xa;  @map_extent_height/2-@para['TopMargin']),&#xd;&#xa; translate(@p0,(1+@para['PhotoByGap'])*@Gap*@i,0)&#xd;&#xa;)))))&#xd;&#xa;" layerType="PointGeometry" centroidWhole="0" repeatDistanceMapUnitScale="3x:0,0,0,0,0,0" distMapUnitScale="3x:0,0,0,0,0,0" offsetType="1" placementFlags="10" quadOffset="1" overlapHandling="PreventOverlap" predefinedPositionOrder="TR,TL,BR,BL,R,L,TSR,BSR" dist="0" polygonPlacementFlags="2" offsetUnits="MM" maxCurvedCharAngleOut="-25" repeatDistanceUnits="MM" maxCurvedCharAngleIn="25" repeatDistance="0" centroidInside="0" rotationAngle="0" lineAnchorTextPoint="CenterOfText" overrunDistanceUnit="MM" rotationUnit="AngleDegrees" lineAnchorPercent="0.5" overrunDistance="0" placement="1" preserveRotation="1" lineAnchorType="0"/>
          <rendering fontLimitPixelSize="0" mergeLines="0" scaleMin="0" obstacle="1" unplacedVisibility="0" zIndex="0" obstacleFactor="1" fontMaxPixelSize="10000" obstacleType="1" labelPerPart="0" scaleVisibility="0" minFeatureSize="0" maxNumLabels="2000" fontMinPixelSize="3" scaleMax="0" limitNumLabels="0" drawLabels="1" upsidedownLabels="0"/>
          <dd_properties>
            <Option type="Map">
              <Option type="QString" value="" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="Color">
                  <Option type="bool" value="true" name="active"/>
                  <Option type="QString" value="darker( @PhotoView_Color,200)" name="expression"/>
                  <Option type="int" value="3" name="type"/>
                </Option>
                <Option type="Map" name="Size">
                  <Option type="bool" value="true" name="active"/>
                  <Option type="QString" value="/*&#xd;&#xa;ラベルの高さ&#xd;&#xa;文字数が多い場合、縮小する。&#xd;&#xa;プロポーショナルフォントは半角の幅が不定なので、幅を@SingleByteCaracterWidthで仮定する。&#xd;&#xa;*/&#xd;&#xa;&#xd;&#xa;with_variable('para',map(&#xd;&#xa; 'Number',  to_int( coalesce(@PhotoView_Number , 8) *if( @qgis_platform&lt;>'mobile',1,if( @map_extent_width > @map_extent_height ,1, @map_extent_width / @map_extent_height ))) ,&#xd;&#xa; 'TopMargin', to_real(coalesce(@PhotoView_TopMargin ,6.0)+if( @qgis_platform='mobile',3,0))*@map_scale/1000,&#xd;&#xa; 'SideMargin', if( @qgis_platform='mobile',9,1) * @map_scale / 1000,&#xd;&#xa; 'PhotoByGap', 15.0),&#xd;&#xa;with_variable('Gap',(@map_extent_width - @para['SideMargin']*2) /((@para['PhotoByGap']+1)*@para['Number']-1),&#xd;&#xa;with_variable('SingleByteCaracterWidth',to_real(coalesce(@PhotoView_SingleByteCaracterWidth ,0.7)),&#xd;&#xa;with_variable('LabelSize', @para['TopMargin']-if(@qgis_platform='mobile',4,1)*@map_scale/1000,&#xd;&#xa;with_variable('PhotoWidth',@para['PhotoByGap']*@Gap,&#xd;&#xa;with_variable('StrLen',&#xd;&#xa;    eval( array_to_string(&#xd;&#xa;    array_foreach(&#xd;&#xa;        array_remove_all( string_to_array(coalesce(  attribute( 'label') , attribute('filename') )   ,''),''),&#xd;&#xa;    if(@element ~ '[ -~]',@SingleByteCaracterWidth,1))&#xd;&#xa;,'+'))&#xd;&#xa;,&#xd;&#xa;if(@PhotoWidth>@LabelSize*@StrLen,&#xd;&#xa;    @LabelSize,@PhotoWidth/@StrLen)&#xd;&#xa;))))))" name="expression"/>
                  <Option type="int" value="3" name="type"/>
                </Option>
              </Option>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </dd_properties>
          <callout type="simple">
            <Option type="Map">
              <Option type="QString" value="pole_of_inaccessibility" name="anchorPoint"/>
              <Option type="int" value="0" name="blendMode"/>
              <Option type="Map" name="ddProperties">
                <Option type="QString" value="" name="name"/>
                <Option name="properties"/>
                <Option type="QString" value="collection" name="type"/>
              </Option>
              <Option type="bool" value="false" name="drawToAllParts"/>
              <Option type="QString" value="0" name="enabled"/>
              <Option type="QString" value="point_on_exterior" name="labelAnchorPoint"/>
              <Option type="QString" value="&lt;symbol type=&quot;line&quot; alpha=&quot;1&quot; clip_to_extent=&quot;1&quot; is_animated=&quot;0&quot; frame_rate=&quot;10&quot; force_rhr=&quot;0&quot; name=&quot;symbol&quot;>&lt;data_defined_properties>&lt;Option type=&quot;Map&quot;>&lt;Option type=&quot;QString&quot; value=&quot;&quot; name=&quot;name&quot;/>&lt;Option name=&quot;properties&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;collection&quot; name=&quot;type&quot;/>&lt;/Option>&lt;/data_defined_properties>&lt;layer enabled=&quot;1&quot; pass=&quot;0&quot; class=&quot;SimpleLine&quot; locked=&quot;0&quot;>&lt;Option type=&quot;Map&quot;>&lt;Option type=&quot;QString&quot; value=&quot;0&quot; name=&quot;align_dash_pattern&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;square&quot; name=&quot;capstyle&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;5;2&quot; name=&quot;customdash&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;3x:0,0,0,0,0,0&quot; name=&quot;customdash_map_unit_scale&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;MM&quot; name=&quot;customdash_unit&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;0&quot; name=&quot;dash_pattern_offset&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;3x:0,0,0,0,0,0&quot; name=&quot;dash_pattern_offset_map_unit_scale&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;MM&quot; name=&quot;dash_pattern_offset_unit&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;0&quot; name=&quot;draw_inside_polygon&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;bevel&quot; name=&quot;joinstyle&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;60,60,60,255&quot; name=&quot;line_color&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;solid&quot; name=&quot;line_style&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;0.3&quot; name=&quot;line_width&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;MM&quot; name=&quot;line_width_unit&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;0&quot; name=&quot;offset&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;3x:0,0,0,0,0,0&quot; name=&quot;offset_map_unit_scale&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;MM&quot; name=&quot;offset_unit&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;0&quot; name=&quot;ring_filter&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;0&quot; name=&quot;trim_distance_end&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;3x:0,0,0,0,0,0&quot; name=&quot;trim_distance_end_map_unit_scale&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;MM&quot; name=&quot;trim_distance_end_unit&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;0&quot; name=&quot;trim_distance_start&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;3x:0,0,0,0,0,0&quot; name=&quot;trim_distance_start_map_unit_scale&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;MM&quot; name=&quot;trim_distance_start_unit&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;0&quot; name=&quot;tweak_dash_pattern_on_corners&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;0&quot; name=&quot;use_custom_dash&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;3x:0,0,0,0,0,0&quot; name=&quot;width_map_unit_scale&quot;/>&lt;/Option>&lt;data_defined_properties>&lt;Option type=&quot;Map&quot;>&lt;Option type=&quot;QString&quot; value=&quot;&quot; name=&quot;name&quot;/>&lt;Option name=&quot;properties&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;collection&quot; name=&quot;type&quot;/>&lt;/Option>&lt;/data_defined_properties>&lt;/layer>&lt;/symbol>" name="lineSymbol"/>
              <Option type="double" value="0" name="minLength"/>
              <Option type="QString" value="3x:0,0,0,0,0,0" name="minLengthMapUnitScale"/>
              <Option type="QString" value="MM" name="minLengthUnit"/>
              <Option type="double" value="0" name="offsetFromAnchor"/>
              <Option type="QString" value="3x:0,0,0,0,0,0" name="offsetFromAnchorMapUnitScale"/>
              <Option type="QString" value="MM" name="offsetFromAnchorUnit"/>
              <Option type="double" value="0" name="offsetFromLabel"/>
              <Option type="QString" value="3x:0,0,0,0,0,0" name="offsetFromLabelMapUnitScale"/>
              <Option type="QString" value="MM" name="offsetFromLabelUnit"/>
            </Option>
          </callout>
        </settings>
      </rule>
    </rules>
  </labeling>
  <blendMode>0</blendMode>
  <featureBlendMode>0</featureBlendMode>
  <fieldConfiguration>
    <field configurationFlags="None" name="fid">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="filename">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="directory">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="altitude">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="direction">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="rotation">
      <editWidget type="Range">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="longitude">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="latitude">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="timestamp">
      <editWidget type="DateTime">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="invisible">
      <editWidget type="CheckBox">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="label">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field configurationFlags="None" name="relpath">
      <editWidget type="ExternalResource">
        <config>
          <Option type="Map">
            <Option type="int" value="1" name="DocumentViewer"/>
            <Option type="int" value="0" name="DocumentViewerHeight"/>
            <Option type="int" value="0" name="DocumentViewerWidth"/>
            <Option type="bool" value="true" name="FileWidget"/>
            <Option type="bool" value="true" name="FileWidgetButton"/>
            <Option type="QString" value="" name="FileWidgetFilter"/>
            <Option type="Map" name="PropertyCollection">
              <Option type="QString" value="" name="name"/>
              <Option type="invalid" name="properties"/>
              <Option type="QString" value="collection" name="type"/>
            </Option>
            <Option type="int" value="1" name="RelativeStorage"/>
            <Option type="QString" value="" name="StorageAuthConfigId"/>
            <Option type="int" value="0" name="StorageMode"/>
            <Option type="QString" value="" name="StorageType"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias index="0" field="fid" name=""/>
    <alias index="1" field="filename" name=""/>
    <alias index="2" field="directory" name=""/>
    <alias index="3" field="altitude" name=""/>
    <alias index="4" field="direction" name=""/>
    <alias index="5" field="rotation" name=""/>
    <alias index="6" field="longitude" name=""/>
    <alias index="7" field="latitude" name=""/>
    <alias index="8" field="timestamp" name=""/>
    <alias index="9" field="invisible" name=""/>
    <alias index="10" field="label" name=""/>
    <alias index="11" field="relpath" name=""/>
  </aliases>
  <defaults>
    <default applyOnUpdate="0" expression="" field="fid"/>
    <default applyOnUpdate="0" expression="" field="filename"/>
    <default applyOnUpdate="0" expression="" field="directory"/>
    <default applyOnUpdate="0" expression="" field="altitude"/>
    <default applyOnUpdate="0" expression="" field="direction"/>
    <default applyOnUpdate="0" expression="" field="rotation"/>
    <default applyOnUpdate="0" expression="" field="longitude"/>
    <default applyOnUpdate="0" expression="" field="latitude"/>
    <default applyOnUpdate="0" expression="" field="timestamp"/>
    <default applyOnUpdate="0" expression="" field="invisible"/>
    <default applyOnUpdate="0" expression="" field="label"/>
    <default applyOnUpdate="0" expression="" field="relpath"/>
  </defaults>
  <constraints>
    <constraint constraints="3" unique_strength="1" notnull_strength="1" exp_strength="0" field="fid"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="filename"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="directory"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="altitude"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="direction"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="rotation"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="longitude"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="latitude"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="timestamp"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="invisible"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="label"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" exp_strength="0" field="relpath"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" exp="" field="fid"/>
    <constraint desc="" exp="" field="filename"/>
    <constraint desc="" exp="" field="directory"/>
    <constraint desc="" exp="" field="altitude"/>
    <constraint desc="" exp="" field="direction"/>
    <constraint desc="" exp="" field="rotation"/>
    <constraint desc="" exp="" field="longitude"/>
    <constraint desc="" exp="" field="latitude"/>
    <constraint desc="" exp="" field="timestamp"/>
    <constraint desc="" exp="" field="invisible"/>
    <constraint desc="" exp="" field="label"/>
    <constraint desc="" exp="" field="relpath"/>
  </constraintExpressions>
  <expressionfields/>
  <attributeactions>
    <defaultAction value="{f3d09ced-e2ce-4a35-956d-c1cb9c8ff1b8}" key="Canvas"/>
    <actionsetting type="5" id="{f3d09ced-e2ce-4a35-956d-c1cb9c8ff1b8}" capture="0" isEnabledOnlyWhenEditable="0" notificationMessage="" shortTitle="" action="[%replace(&#xd;&#xa; coalesce( attribute( 'photo'),&#xd;&#xa;  file_path( layer_property(  @layer ,'path')) || '/' || attribute('relpath')&#xd;&#xa; )&#xd;&#xa;, '\\','/')%]" icon="" name="open">
      <actionScope id="Canvas"/>
      <actionScope id="Layer"/>
      <actionScope id="Field"/>
      <actionScope id="Feature"/>
    </actionsetting>
  </attributeactions>
  <attributetableconfig sortExpression="" actionWidgetStyle="dropDown" sortOrder="0">
    <columns>
      <column type="field" hidden="0" width="-1" name="fid"/>
      <column type="field" hidden="0" width="-1" name="filename"/>
      <column type="field" hidden="0" width="-1" name="directory"/>
      <column type="field" hidden="0" width="-1" name="altitude"/>
      <column type="field" hidden="0" width="-1" name="direction"/>
      <column type="field" hidden="0" width="-1" name="rotation"/>
      <column type="field" hidden="0" width="-1" name="longitude"/>
      <column type="field" hidden="0" width="-1" name="latitude"/>
      <column type="field" hidden="0" width="-1" name="timestamp"/>
      <column type="field" hidden="0" width="-1" name="invisible"/>
      <column type="field" hidden="0" width="-1" name="label"/>
      <column type="field" hidden="0" width="-1" name="relpath"/>
      <column type="actions" hidden="1" width="-1"/>
    </columns>
  </attributetableconfig>
  <conditionalstyles>
    <rowstyles/>
    <fieldstyles/>
  </conditionalstyles>
  <storedexpressions/>
  <editform tolerant="1"></editform>
  <editforminit/>
  <editforminitcodesource>0</editforminitcodesource>
  <editforminitfilepath></editforminitfilepath>
  <editforminitcode><![CDATA[# -*- coding: utf-8 -*-
"""
QGISフォームは、フォームを開いた直後に実行されるPython関数を設定できます。

この関数でロジックを追加できます

"Python Init function"に関数の名前を入力します
以下はコード例です:
"""
from qgis.PyQt.QtWidgets import QWidget

def my_form_open(dialog, layer, feature):
    geom = feature.geometry()
    control = dialog.findChild(QWidget, "MyLineEdit")
]]></editforminitcode>
  <featformsuppress>0</featformsuppress>
  <editorlayout>generatedlayout</editorlayout>
  <attributeEditorForm>
    <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
      <labelFont style="" italic="0" strikethrough="0" bold="0" underline="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0"/>
    </labelStyle>
    <attributeEditorField index="0" showLabel="1" name="fid">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont style="" italic="0" strikethrough="0" bold="0" underline="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="1" showLabel="1" name="filename">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont style="" italic="0" strikethrough="0" bold="0" underline="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="2" showLabel="1" name="directory">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont style="" italic="0" strikethrough="0" bold="0" underline="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="3" showLabel="1" name="altitude">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont style="" italic="0" strikethrough="0" bold="0" underline="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="4" showLabel="1" name="direction">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont style="" italic="0" strikethrough="0" bold="0" underline="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="5" showLabel="1" name="rotation">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont style="" italic="0" strikethrough="0" bold="0" underline="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="6" showLabel="1" name="longitude">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont style="" italic="0" strikethrough="0" bold="0" underline="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="7" showLabel="1" name="latitude">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont style="" italic="0" strikethrough="0" bold="0" underline="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="8" showLabel="1" name="timestamp">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont style="" italic="0" strikethrough="0" bold="0" underline="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="9" showLabel="1" name="invisible">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont style="" italic="0" strikethrough="0" bold="0" underline="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="10" showLabel="1" name="label">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont style="" italic="0" strikethrough="0" bold="0" underline="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField index="11" showLabel="1" name="relpath">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont style="" italic="0" strikethrough="0" bold="0" underline="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer groupBox="1" columnCount="2" visibilityExpressionEnabled="0" visibilityExpression="&quot;filename&quot;" backgroundColor="#ff0000" collapsedExpressionEnabled="0" collapsed="1" collapsedExpression="" showLabel="1" name="tttt">
      <labelStyle overrideLabelFont="0" overrideLabelColor="0" labelColor="0,0,0,255">
        <labelFont style="" italic="0" strikethrough="0" bold="0" underline="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0"/>
      </labelStyle>
    </attributeEditorContainer>
  </attributeEditorForm>
  <editable>
    <field editable="1" name="altitude"/>
    <field editable="1" name="direction"/>
    <field editable="1" name="directory"/>
    <field editable="1" name="fid"/>
    <field editable="1" name="filename"/>
    <field editable="1" name="invisible"/>
    <field editable="1" name="label"/>
    <field editable="1" name="latitude"/>
    <field editable="1" name="longitude"/>
    <field editable="1" name="relpath"/>
    <field editable="1" name="rotation"/>
    <field editable="1" name="timestamp"/>
  </editable>
  <labelOnTop>
    <field labelOnTop="0" name="altitude"/>
    <field labelOnTop="0" name="direction"/>
    <field labelOnTop="0" name="directory"/>
    <field labelOnTop="0" name="fid"/>
    <field labelOnTop="0" name="filename"/>
    <field labelOnTop="0" name="invisible"/>
    <field labelOnTop="0" name="label"/>
    <field labelOnTop="0" name="latitude"/>
    <field labelOnTop="0" name="longitude"/>
    <field labelOnTop="0" name="relpath"/>
    <field labelOnTop="0" name="rotation"/>
    <field labelOnTop="0" name="timestamp"/>
  </labelOnTop>
  <reuseLastValue>
    <field reuseLastValue="0" name="altitude"/>
    <field reuseLastValue="0" name="direction"/>
    <field reuseLastValue="0" name="directory"/>
    <field reuseLastValue="0" name="fid"/>
    <field reuseLastValue="0" name="filename"/>
    <field reuseLastValue="0" name="invisible"/>
    <field reuseLastValue="0" name="label"/>
    <field reuseLastValue="0" name="latitude"/>
    <field reuseLastValue="0" name="longitude"/>
    <field reuseLastValue="0" name="relpath"/>
    <field reuseLastValue="0" name="rotation"/>
    <field reuseLastValue="0" name="timestamp"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <layerGeometryType>0</layerGeometryType>
</qgis>
