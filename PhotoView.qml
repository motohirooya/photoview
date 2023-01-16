<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="Symbology|Labeling|Fields|Forms|Actions|AttributeTable" version="3.28.2-Firenze" labelsEnabled="1">
  <renderer-v2 enableorderby="0" forceraster="0" referencescale="-1" type="RuleRenderer" symbollevels="0">
    <rules key="{4c83798d-3edf-4754-852c-330910c581ec}">
      <rule label="PHOTO" key="{580b1a51-0fff-4616-b191-d07f43f2f41a}" filter="/*&#xd;&#xa;写真表示地物かの条件判定　シンボロジ、ラベル共通&#xd;&#xa;*/&#xd;&#xa;with_variable('para',map(&#xd;&#xa; 'Number',  to_int( coalesce(@PhotoView_Number , 8) *if( @qgis_platform&lt;>'mobile',1,if( @map_extent_width > @map_extent_height ,1, @map_extent_width / @map_extent_height ))) ,&#xd;&#xa; 'TopMargin', to_real(coalesce(@PhotoView_TopMargin ,6.0)+if( @qgis_platform='mobile',3,0))*@map_scale/1000,&#xd;&#xa; 'SideMargin', if( @qgis_platform='mobile',9,1) * @map_scale / 1000,&#xd;&#xa; 'PhotoByGap', 15.0),&#xd;&#xa;with_variable('Gap',(@map_extent_width - @para['SideMargin']*2) /((@para['PhotoByGap']+1)*@para['Number']-1),&#xd;&#xa;with_variable('Extent',&#xd;&#xa;&#x9; intersection(  @map_extent , translate(  @map_extent ,0,-@para['PhotoByGap']*@Gap*0.800-@para['TopMargin'])),&#xd;&#xa;CASE &#xd;&#xa;WHEN  @map_rotation &lt;> 0 THEN false&#xd;&#xa;WHEN  attribute(  'invisible' ) THEN false&#xd;&#xa;WHEN  not within(   $geometry , @Extent )  THEN false&#xd;&#xa;ELSE&#xd;&#xa;with_variable('DistRank', array_find(&#xd;&#xa;&#x9; array_foreach(&#xd;&#xa;&#x9;array_sort( &#xd;&#xa;&#x9;&#x9;array_agg(  array(  distance(  @map_extent_center , $geometry ),$id  ) ,filter:=if( attribute(  'invisible' ),false,true) and within(   $geometry , @Extent ))&#xd;&#xa;&#x9;),&#xd;&#xa;&#x9;@element[1])&#xd;&#xa;&#x9;,$id),&#xd;&#xa;@DistRank&lt;@para['Number'])&#xd;&#xa;END&#xd;&#xa;)))&#xd;&#xa;&#xd;&#xa;" symbol="0"/>
      <rule label="far" key="{11dde42b-66f3-4248-b456-51b3af11524f}" filter="ELSE" symbol="1"/>
      <rule label="invisible" key="{3881f3a2-408f-4e64-84f6-d42475562fae}" filter="/*&#xd;&#xa;invisible フィールドがtrueの場合は写真表示から除外、アイコンはグレー&#xd;&#xa;*/&#xd;&#xa;  attribute( 'invisible' )&#xd;&#xa;&#xd;&#xa;/*&#xd;&#xa;photoview履歴・メモ,motohirooya&#xd;&#xa;2022/2/23　動くものができる&#xd;&#xa;2022/3/2&#xd;&#xa;・引き出し線を曲線（smooth）、引き出し線の起点をラスタ画像マーカと同じに。このため、@LEADER変数が不要に&#xd;&#xa;・invisibleフィールド（真偽値）を導入、値がtrueの場合は写真を非表示、それ以外（false,nll,フィールドが無い場合）は写真を表示）&#xd;&#xa;・photoview_inportモデル作成。invisibleフィールドの追加は属性リファクタリング（フィールド演算、フィールド追加では、真偽値が選べない。バージョンアップで「ジオタグ（位置情報）付きの写真」の出力がかわることに注意）&#xd;&#xa;・撮影位置を矢印から扇に変更&#xd;&#xa;2022/3/13 色の調整、コメントの記載&#xd;&#xa;2022/9/14 ラベルが衝突して表示されないことがあったので、プロジェクト変数に全角文字に対する半角文字の幅のパラメータを追加し、ラベルサイズの計算を行うよう変更（以前は0.66・・・の固定値を使用していた）&#xd;&#xa;ラベルサイズのプロジェクト変数を削除し、写真の上の余白-1mmを最大ラベルサイズとした。&#xd;&#xa;表示範囲外の地物は写真を表示しない条件を追加&#xd;&#xa;2022/9/19 写真と引き出し線が重ならないよう、写真を表示する上部はフィルタ範囲から除外（写真の縦横比は0.800を仮定）&#xd;&#xa;2022/9/23 label フィールド追加、値がある場合はラベルのフィールドとして使用&#xd;&#xa;2022/9/30 PhotoView_SingleByteCaracterWidth の既定値を0.8→0.7&#xd;&#xa;中心点との距離が同一の場合、順序がおかしくなる可能性があったのを修正&#xd;&#xa;labelフィールドがない場合、文字サイズの計算がおかしかったのを修正&#xd;&#xa;2022/10/24 プロジェクト変数未設定時の文字サイズ修正、方位角nullの場合は●を表示、写真選択基準の距離の起点を画面中心から対象範囲（@Extent）に&#xd;&#xa;2022/11/8&#xd;&#xa;シンボルとラベルの色を変数PhotoView_Colorに設定。Qfield用の色々調整。photoフィールドがない場合はrelpathフィールドを参照するように&#xd;&#xa;2022/11/17 with_variableをマップ型オブジェクトでまとめた。写真選択基準の距離の起点を画面中心に戻した。&#xd;&#xa;2023/1/16 &quot;photo&quot;の写真がない場合、 @project_folder  ||'/'||  &quot;relpath&quot;を使用する。 &#xd;&#xa;既知の問題&#xd;&#xa;・QGIS3.16では縦撮りの写真が横になる。QGIS3.22では縦になるがアンカー位置が写真の中間部になる（期待されるのは写真上部中央）&#xd;&#xa;・地図の回転には対応しない&#xd;&#xa;*/" symbol="2"/>
    </rules>
    <symbols>
      <symbol force_rhr="0" frame_rate="10" alpha="0.6" clip_to_extent="1" type="marker" name="0" is_animated="0">
        <data_defined_properties>
          <Option type="Map">
            <Option value="" type="QString" name="name"/>
            <Option name="properties"/>
            <Option value="collection" type="QString" name="type"/>
          </Option>
        </data_defined_properties>
        <layer class="GeometryGenerator" pass="6" enabled="1" locked="0">
          <Option type="Map">
            <Option value="Line" type="QString" name="SymbolType"/>
            <Option value="/*&#xd;&#xa;写真と撮影位置を結ぶライン 写真のアンカー位置を@piとし、一旦下に下げてから撮影位置と結ぶ&#xd;&#xa;*/&#xd;&#xa;&#xd;&#xa;with_variable('para',map(&#xd;&#xa; 'Number',  to_int( coalesce(@PhotoView_Number , 8) *if( @qgis_platform&lt;>'mobile',1,if( @map_extent_width > @map_extent_height ,1, @map_extent_width / @map_extent_height ))) ,&#xd;&#xa; 'TopMargin', to_real(coalesce(@PhotoView_TopMargin ,6.0)+if( @qgis_platform='mobile',3,0))*@map_scale/1000,&#xd;&#xa; 'SideMargin', if( @qgis_platform='mobile',9,1) * @map_scale / 1000,&#xd;&#xa; 'PhotoByGap', 15.0),&#xd;&#xa;with_variable('Gap',(@map_extent_width - @para['SideMargin']*2) /((@para['PhotoByGap']+1)*@para['Number']-1),&#xd;&#xa;with_variable('Extent',intersection(  @map_extent , translate(  @map_extent ,0,-@para['PhotoByGap']*@Gap*0.800-@para['TopMargin'])),&#xd;&#xa;with_variable('i',  --左から何番目か&#xd;&#xa; array_find(&#xd;&#xa;  array_foreach(&#xd;&#xa;    array_sort(&#xd;&#xa;&#x9; array_foreach( &#xd;&#xa;  &#x9;  array_slice(&#xd;&#xa;       array_sort( &#xd;&#xa;        array_agg(  array(  distance(  @map_extent_center , $geometry ),$id ,$x ) ,filter:=if( attribute(  'invisible' ),false,true) and within(   $geometry , @Extent ))&#xd;&#xa;        )&#xd;&#xa;      ,0,@para['Number']-1)&#xd;&#xa;&#x9;, array_reverse(@element))&#xd;&#xa;    )&#xd;&#xa;  ,@element[1])&#xd;&#xa; ,$id),&#x9;&#x9;-- i の定義終わり&#xd;&#xa; with_variable('p0',translate(@map_extent_center,@para['SideMargin']+(@para['PhotoByGap']/2)*@Gap-@map_extent_width/2,&#xd;&#xa;  @map_extent_height/2-@para['TopMargin']),&#xd;&#xa;with_variable('pi',&#xd;&#xa;&#x9;translate(@p0,(1+@para['PhotoByGap'])*@Gap*@i,0),&#xd;&#xa;  smooth( make_line( @pi, make_point(x(@pi), (y(@pi)+y($geometry))/2 ) , $geometry  ) ,5 ) &#xd;&#xa;))))))&#xd;&#xa;" type="QString" name="geometryModifier"/>
            <Option value="MapUnit" type="QString" name="units"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" type="QString" name="name"/>
              <Option name="properties"/>
              <Option value="collection" type="QString" name="type"/>
            </Option>
          </data_defined_properties>
          <symbol force_rhr="0" frame_rate="10" alpha="1" clip_to_extent="1" type="line" name="@0@0" is_animated="0">
            <data_defined_properties>
              <Option type="Map">
                <Option value="" type="QString" name="name"/>
                <Option name="properties"/>
                <Option value="collection" type="QString" name="type"/>
              </Option>
            </data_defined_properties>
            <layer class="SimpleLine" pass="0" enabled="1" locked="0">
              <Option type="Map">
                <Option value="0" type="QString" name="align_dash_pattern"/>
                <Option value="square" type="QString" name="capstyle"/>
                <Option value="5;2" type="QString" name="customdash"/>
                <Option value="3x:0,0,0,0,0,0" type="QString" name="customdash_map_unit_scale"/>
                <Option value="MM" type="QString" name="customdash_unit"/>
                <Option value="0" type="QString" name="dash_pattern_offset"/>
                <Option value="3x:0,0,0,0,0,0" type="QString" name="dash_pattern_offset_map_unit_scale"/>
                <Option value="MM" type="QString" name="dash_pattern_offset_unit"/>
                <Option value="0" type="QString" name="draw_inside_polygon"/>
                <Option value="bevel" type="QString" name="joinstyle"/>
                <Option value="15,245,245,255" type="QString" name="line_color"/>
                <Option value="solid" type="QString" name="line_style"/>
                <Option value="0.2" type="QString" name="line_width"/>
                <Option value="MM" type="QString" name="line_width_unit"/>
                <Option value="0" type="QString" name="offset"/>
                <Option value="3x:0,0,0,0,0,0" type="QString" name="offset_map_unit_scale"/>
                <Option value="MM" type="QString" name="offset_unit"/>
                <Option value="0" type="QString" name="ring_filter"/>
                <Option value="0" type="QString" name="trim_distance_end"/>
                <Option value="3x:0,0,0,0,0,0" type="QString" name="trim_distance_end_map_unit_scale"/>
                <Option value="MM" type="QString" name="trim_distance_end_unit"/>
                <Option value="0" type="QString" name="trim_distance_start"/>
                <Option value="3x:0,0,0,0,0,0" type="QString" name="trim_distance_start_map_unit_scale"/>
                <Option value="MM" type="QString" name="trim_distance_start_unit"/>
                <Option value="0" type="QString" name="tweak_dash_pattern_on_corners"/>
                <Option value="0" type="QString" name="use_custom_dash"/>
                <Option value="3x:0,0,0,0,0,0" type="QString" name="width_map_unit_scale"/>
              </Option>
              <data_defined_properties>
                <Option type="Map">
                  <Option value="" type="QString" name="name"/>
                  <Option type="Map" name="properties">
                    <Option type="Map" name="outlineColor">
                      <Option value="true" type="bool" name="active"/>
                      <Option value="@PhotoView_Color" type="QString" name="expression"/>
                      <Option value="3" type="int" name="type"/>
                    </Option>
                  </Option>
                  <Option value="collection" type="QString" name="type"/>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </layer>
        <layer class="SimpleMarker" pass="4" enabled="1" locked="0">
          <Option type="Map">
            <Option value="0" type="QString" name="angle"/>
            <Option value="square" type="QString" name="cap_style"/>
            <Option value="15,245,245,255" type="QString" name="color"/>
            <Option value="1" type="QString" name="horizontal_anchor_point"/>
            <Option value="bevel" type="QString" name="joinstyle"/>
            <Option value="quarter_circle" type="QString" name="name"/>
            <Option value="0,0" type="QString" name="offset"/>
            <Option value="3x:0,0,0,0,0,0" type="QString" name="offset_map_unit_scale"/>
            <Option value="MM" type="QString" name="offset_unit"/>
            <Option value="35,35,35,255" type="QString" name="outline_color"/>
            <Option value="solid" type="QString" name="outline_style"/>
            <Option value="0.2" type="QString" name="outline_width"/>
            <Option value="3x:0,0,0,0,0,0" type="QString" name="outline_width_map_unit_scale"/>
            <Option value="MM" type="QString" name="outline_width_unit"/>
            <Option value="diameter" type="QString" name="scale_method"/>
            <Option value="5" type="QString" name="size"/>
            <Option value="3x:0,0,0,0,0,0" type="QString" name="size_map_unit_scale"/>
            <Option value="MM" type="QString" name="size_unit"/>
            <Option value="1" type="QString" name="vertical_anchor_point"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" type="QString" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="angle">
                  <Option value="true" type="bool" name="active"/>
                  <Option value="&quot;direction&quot; + 45" type="QString" name="expression"/>
                  <Option value="3" type="int" name="type"/>
                </Option>
                <Option type="Map" name="enabled">
                  <Option value="true" type="bool" name="active"/>
                  <Option value="&quot;direction&quot; is not null" type="QString" name="expression"/>
                  <Option value="3" type="int" name="type"/>
                </Option>
                <Option type="Map" name="fillColor">
                  <Option value="true" type="bool" name="active"/>
                  <Option value="@PhotoView_Color" type="QString" name="expression"/>
                  <Option value="3" type="int" name="type"/>
                </Option>
              </Option>
              <Option value="collection" type="QString" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer class="SimpleMarker" pass="0" enabled="1" locked="0">
          <Option type="Map">
            <Option value="0" type="QString" name="angle"/>
            <Option value="square" type="QString" name="cap_style"/>
            <Option value="15,245,245,255" type="QString" name="color"/>
            <Option value="1" type="QString" name="horizontal_anchor_point"/>
            <Option value="bevel" type="QString" name="joinstyle"/>
            <Option value="circle" type="QString" name="name"/>
            <Option value="0,0" type="QString" name="offset"/>
            <Option value="3x:0,0,0,0,0,0" type="QString" name="offset_map_unit_scale"/>
            <Option value="MM" type="QString" name="offset_unit"/>
            <Option value="35,35,35,255" type="QString" name="outline_color"/>
            <Option value="solid" type="QString" name="outline_style"/>
            <Option value="0.2" type="QString" name="outline_width"/>
            <Option value="3x:0,0,0,0,0,0" type="QString" name="outline_width_map_unit_scale"/>
            <Option value="MM" type="QString" name="outline_width_unit"/>
            <Option value="diameter" type="QString" name="scale_method"/>
            <Option value="2" type="QString" name="size"/>
            <Option value="3x:0,0,0,0,0,0" type="QString" name="size_map_unit_scale"/>
            <Option value="MM" type="QString" name="size_unit"/>
            <Option value="1" type="QString" name="vertical_anchor_point"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" type="QString" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="angle">
                  <Option value="false" type="bool" name="active"/>
                  <Option value="1" type="int" name="type"/>
                  <Option value="" type="QString" name="val"/>
                </Option>
                <Option type="Map" name="enabled">
                  <Option value="true" type="bool" name="active"/>
                  <Option value="&quot;direction&quot; is null" type="QString" name="expression"/>
                  <Option value="3" type="int" name="type"/>
                </Option>
                <Option type="Map" name="fillColor">
                  <Option value="true" type="bool" name="active"/>
                  <Option value="@PhotoView_Color" type="QString" name="expression"/>
                  <Option value="3" type="int" name="type"/>
                </Option>
              </Option>
              <Option value="collection" type="QString" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer class="SimpleMarker" pass="5" enabled="1" locked="0">
          <Option type="Map">
            <Option value="0" type="QString" name="angle"/>
            <Option value="square" type="QString" name="cap_style"/>
            <Option value="0,0,0,255" type="QString" name="color"/>
            <Option value="1" type="QString" name="horizontal_anchor_point"/>
            <Option value="bevel" type="QString" name="joinstyle"/>
            <Option value="circle" type="QString" name="name"/>
            <Option value="0,0" type="QString" name="offset"/>
            <Option value="3x:0,0,0,0,0,0" type="QString" name="offset_map_unit_scale"/>
            <Option value="MM" type="QString" name="offset_unit"/>
            <Option value="35,35,35,255" type="QString" name="outline_color"/>
            <Option value="no" type="QString" name="outline_style"/>
            <Option value="0" type="QString" name="outline_width"/>
            <Option value="3x:0,0,0,0,0,0" type="QString" name="outline_width_map_unit_scale"/>
            <Option value="MM" type="QString" name="outline_width_unit"/>
            <Option value="diameter" type="QString" name="scale_method"/>
            <Option value="0.6" type="QString" name="size"/>
            <Option value="3x:0,0,0,0,0,0" type="QString" name="size_map_unit_scale"/>
            <Option value="MM" type="QString" name="size_unit"/>
            <Option value="1" type="QString" name="vertical_anchor_point"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" type="QString" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="angle">
                  <Option value="false" type="bool" name="active"/>
                  <Option value="" type="QString" name="expression"/>
                  <Option value="3" type="int" name="type"/>
                </Option>
              </Option>
              <Option value="collection" type="QString" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer class="GeometryGenerator" pass="7" enabled="1" locked="0">
          <Option type="Map">
            <Option value="Marker" type="QString" name="SymbolType"/>
            <Option value="/*&#xd;&#xa;ラスタ画像マーカーのアンカー位置、ラベルのアンカー位置　共通&#xd;&#xa;*/&#xd;&#xa;with_variable('para',map(&#xd;&#xa; 'Number',  to_int( coalesce(@PhotoView_Number , 8) *if( @qgis_platform&lt;>'mobile',1,if( @map_extent_width > @map_extent_height ,1, @map_extent_width / @map_extent_height ))) ,&#xd;&#xa; 'TopMargin', to_real(coalesce(@PhotoView_TopMargin ,6.0))*@map_scale/1000,&#xd;&#xa; 'SideMargin', if( @qgis_platform='mobile',9,1) * @map_scale / 1000,&#xd;&#xa; 'PhotoByGap', 15.0),&#xd;&#xa;with_variable('Gap',(@map_extent_width - @para['SideMargin']*2) /((@para['PhotoByGap']+1)*@para['Number']-1),&#xd;&#xa;with_variable('Extent',intersection(  @map_extent , translate(  @map_extent ,0,-@para['PhotoByGap']*@Gap*0.800-@para['TopMargin'])),&#xd;&#xa;with_variable('i',  --左から何番目か&#xd;&#xa; array_find(&#xd;&#xa;  array_foreach(&#xd;&#xa;    array_sort(&#xd;&#xa;&#x9; array_foreach( &#xd;&#xa;  &#x9;  array_slice(&#xd;&#xa;       array_sort( &#xd;&#xa;        array_agg(  array(  distance(  @map_extent_center , $geometry ),$id ,$x ) ,filter:=if( attribute(  'invisible' ),false,true) and within(   $geometry , @Extent ))&#xd;&#xa;        )&#xd;&#xa;      ,0,@para['Number']-1)&#xd;&#xa;&#x9;, array_reverse(@element))&#xd;&#xa;    )&#xd;&#xa;  ,@element[1])&#xd;&#xa; ,$id),&#x9;&#x9;-- i の定義終わり&#xd;&#xa; with_variable('p0',translate(@map_extent_center,@para['SideMargin']+(@para['PhotoByGap']/2)*@Gap-@map_extent_width/2,&#xd;&#xa;  @map_extent_height/2-@para['TopMargin']),&#xd;&#xa; translate(@p0,(1+@para['PhotoByGap'])*@Gap*@i,0)&#xd;&#xa;)))))&#xd;&#xa;" type="QString" name="geometryModifier"/>
            <Option value="MapUnit" type="QString" name="units"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" type="QString" name="name"/>
              <Option name="properties"/>
              <Option value="collection" type="QString" name="type"/>
            </Option>
          </data_defined_properties>
          <symbol force_rhr="0" frame_rate="10" alpha="1" clip_to_extent="1" type="marker" name="@0@4" is_animated="0">
            <data_defined_properties>
              <Option type="Map">
                <Option value="" type="QString" name="name"/>
                <Option name="properties"/>
                <Option value="collection" type="QString" name="type"/>
              </Option>
            </data_defined_properties>
            <layer class="RasterMarker" pass="0" enabled="1" locked="0">
              <Option type="Map">
                <Option value="1" type="QString" name="alpha"/>
                <Option value="0" type="QString" name="angle"/>
                <Option value="0" type="QString" name="fixedAspectRatio"/>
                <Option value="1" type="QString" name="horizontal_anchor_point"/>
                <Option value="" type="QString" name="imageFile"/>
                <Option value="0,0" type="QString" name="offset"/>
                <Option value="3x:0,0,0,0,0,0" type="QString" name="offset_map_unit_scale"/>
                <Option value="MM" type="QString" name="offset_unit"/>
                <Option value="diameter" type="QString" name="scale_method"/>
                <Option value="2" type="QString" name="size"/>
                <Option value="3x:0,0,0,0,0,0" type="QString" name="size_map_unit_scale"/>
                <Option value="MapUnit" type="QString" name="size_unit"/>
                <Option value="0" type="QString" name="vertical_anchor_point"/>
              </Option>
              <effect enabled="1" type="effectStack">
                <effect type="dropShadow">
                  <Option type="Map">
                    <Option value="13" type="QString" name="blend_mode"/>
                    <Option value="2.645" type="QString" name="blur_level"/>
                    <Option value="MM" type="QString" name="blur_unit"/>
                    <Option value="3x:0,0,0,0,0,0" type="QString" name="blur_unit_scale"/>
                    <Option value="0,0,0,255" type="QString" name="color"/>
                    <Option value="2" type="QString" name="draw_mode"/>
                    <Option value="0" type="QString" name="enabled"/>
                    <Option value="135" type="QString" name="offset_angle"/>
                    <Option value="2" type="QString" name="offset_distance"/>
                    <Option value="MM" type="QString" name="offset_unit"/>
                    <Option value="3x:0,0,0,0,0,0" type="QString" name="offset_unit_scale"/>
                    <Option value="1" type="QString" name="opacity"/>
                  </Option>
                </effect>
                <effect type="outerGlow">
                  <Option type="Map">
                    <Option value="0" type="QString" name="blend_mode"/>
                    <Option value="0.5" type="QString" name="blur_level"/>
                    <Option value="MM" type="QString" name="blur_unit"/>
                    <Option value="3x:0,0,0,0,0,0" type="QString" name="blur_unit_scale"/>
                    <Option value="0,0,255,255" type="QString" name="color1"/>
                    <Option value="0,255,0,255" type="QString" name="color2"/>
                    <Option value="0" type="QString" name="color_type"/>
                    <Option value="ccw" type="QString" name="direction"/>
                    <Option value="0" type="QString" name="discrete"/>
                    <Option value="2" type="QString" name="draw_mode"/>
                    <Option value="1" type="QString" name="enabled"/>
                    <Option value="0.5" type="QString" name="opacity"/>
                    <Option value="gradient" type="QString" name="rampType"/>
                    <Option value="255,255,255,255" type="QString" name="single_color"/>
                    <Option value="rgb" type="QString" name="spec"/>
                    <Option value="1" type="QString" name="spread"/>
                    <Option value="MM" type="QString" name="spread_unit"/>
                    <Option value="3x:0,0,0,0,0,0" type="QString" name="spread_unit_scale"/>
                  </Option>
                </effect>
                <effect type="drawSource">
                  <Option type="Map">
                    <Option value="0" type="QString" name="blend_mode"/>
                    <Option value="2" type="QString" name="draw_mode"/>
                    <Option value="1" type="QString" name="enabled"/>
                    <Option value="1" type="QString" name="opacity"/>
                  </Option>
                </effect>
                <effect type="innerShadow">
                  <Option type="Map">
                    <Option value="13" type="QString" name="blend_mode"/>
                    <Option value="2.645" type="QString" name="blur_level"/>
                    <Option value="MM" type="QString" name="blur_unit"/>
                    <Option value="3x:0,0,0,0,0,0" type="QString" name="blur_unit_scale"/>
                    <Option value="0,0,0,255" type="QString" name="color"/>
                    <Option value="2" type="QString" name="draw_mode"/>
                    <Option value="0" type="QString" name="enabled"/>
                    <Option value="135" type="QString" name="offset_angle"/>
                    <Option value="2" type="QString" name="offset_distance"/>
                    <Option value="MM" type="QString" name="offset_unit"/>
                    <Option value="3x:0,0,0,0,0,0" type="QString" name="offset_unit_scale"/>
                    <Option value="1" type="QString" name="opacity"/>
                  </Option>
                </effect>
                <effect type="innerGlow">
                  <Option type="Map">
                    <Option value="0" type="QString" name="blend_mode"/>
                    <Option value="2.645" type="QString" name="blur_level"/>
                    <Option value="MM" type="QString" name="blur_unit"/>
                    <Option value="3x:0,0,0,0,0,0" type="QString" name="blur_unit_scale"/>
                    <Option value="0,0,255,255" type="QString" name="color1"/>
                    <Option value="0,255,0,255" type="QString" name="color2"/>
                    <Option value="0" type="QString" name="color_type"/>
                    <Option value="ccw" type="QString" name="direction"/>
                    <Option value="0" type="QString" name="discrete"/>
                    <Option value="2" type="QString" name="draw_mode"/>
                    <Option value="0" type="QString" name="enabled"/>
                    <Option value="0.5" type="QString" name="opacity"/>
                    <Option value="gradient" type="QString" name="rampType"/>
                    <Option value="255,255,255,255" type="QString" name="single_color"/>
                    <Option value="rgb" type="QString" name="spec"/>
                    <Option value="2" type="QString" name="spread"/>
                    <Option value="MM" type="QString" name="spread_unit"/>
                    <Option value="3x:0,0,0,0,0,0" type="QString" name="spread_unit_scale"/>
                  </Option>
                </effect>
              </effect>
              <data_defined_properties>
                <Option type="Map">
                  <Option value="" type="QString" name="name"/>
                  <Option type="Map" name="properties">
                    <Option type="Map" name="name">
                      <Option value="true" type="bool" name="active"/>
                      <Option value="/*&#xd;&#xa;写真ファイルへのパス&#xd;&#xa;photo 絶対パス（ジオタグ付き写真の出力&#xd;&#xa;relpath　プロジェクトフォルダからの相対パス&#xd;&#xa;*/&#xd;&#xa;&#xd;&#xa;replace(&#xd;&#xa;&#x9;CASE &#xd;&#xa;&#x9;WHEN file_exists(attribute( 'photo')) THEN attribute( 'photo')&#xd;&#xa;&#x9;ELSE &#xd;&#xa;&#x9; @project_folder  || '/' || attribute('relpath')&#xd;&#xa;&#x9;END&#xd;&#xa;, '\\','/')" type="QString" name="expression"/>
                      <Option value="3" type="int" name="type"/>
                    </Option>
                    <Option type="Map" name="width">
                      <Option value="true" type="bool" name="active"/>
                      <Option value="/*&#xd;&#xa;写真の幅　地理単位(m)&#xd;&#xa;　写真数、左右端の余白、写真と写真間隔の比　により写真の幅を決定&#xd;&#xa;　デスクトップ（モバイル以外）　左右端の余白は1mm&#xd;&#xa;　モバイル　左右端の余白は9mm ボタンの幅をとるため、横向きはデスクトップと同じ写真数、縦は縦横比により減らす。&#xd;&#xa;*/&#xd;&#xa;&#xd;&#xa;with_variable('para',map(&#xd;&#xa; 'Number',  to_int( coalesce(@PhotoView_Number , 8) *if( @qgis_platform&lt;>'mobile',1,if( @map_extent_width > @map_extent_height ,1, @map_extent_width / @map_extent_height ))) ,&#xd;&#xa; 'TopMargin', to_real(coalesce(@PhotoView_TopMargin ,6.0)+if( @qgis_platform='mobile',3,0))*@map_scale/1000,&#xd;&#xa; 'SideMargin', if( @qgis_platform='mobile',9,1) * @map_scale / 1000,&#xd;&#xa; 'PhotoByGap', 15.0),&#xd;&#xa;with_variable('Gap',(@map_extent_width - @para['SideMargin']*2) /((@para['PhotoByGap']+1)*@para['Number']-1),&#xd;&#xa;&#x9;@para['PhotoByGap']*@Gap)&#xd;&#xa;)" type="QString" name="expression"/>
                      <Option value="3" type="int" name="type"/>
                    </Option>
                  </Option>
                  <Option value="collection" type="QString" name="type"/>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol force_rhr="0" frame_rate="10" alpha="0.6" clip_to_extent="1" type="marker" name="1" is_animated="0">
        <data_defined_properties>
          <Option type="Map">
            <Option value="" type="QString" name="name"/>
            <Option name="properties"/>
            <Option value="collection" type="QString" name="type"/>
          </Option>
        </data_defined_properties>
        <layer class="SimpleMarker" pass="2" enabled="1" locked="0">
          <Option type="Map">
            <Option value="0" type="QString" name="angle"/>
            <Option value="square" type="QString" name="cap_style"/>
            <Option value="255,255,255,255" type="QString" name="color"/>
            <Option value="1" type="QString" name="horizontal_anchor_point"/>
            <Option value="bevel" type="QString" name="joinstyle"/>
            <Option value="quarter_circle" type="QString" name="name"/>
            <Option value="0,0" type="QString" name="offset"/>
            <Option value="3x:0,0,0,0,0,0" type="QString" name="offset_map_unit_scale"/>
            <Option value="MM" type="QString" name="offset_unit"/>
            <Option value="35,35,35,255" type="QString" name="outline_color"/>
            <Option value="solid" type="QString" name="outline_style"/>
            <Option value="0" type="QString" name="outline_width"/>
            <Option value="3x:0,0,0,0,0,0" type="QString" name="outline_width_map_unit_scale"/>
            <Option value="MM" type="QString" name="outline_width_unit"/>
            <Option value="diameter" type="QString" name="scale_method"/>
            <Option value="5" type="QString" name="size"/>
            <Option value="3x:0,0,0,0,0,0" type="QString" name="size_map_unit_scale"/>
            <Option value="MM" type="QString" name="size_unit"/>
            <Option value="1" type="QString" name="vertical_anchor_point"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" type="QString" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="angle">
                  <Option value="true" type="bool" name="active"/>
                  <Option value="&quot;direction&quot; + 45" type="QString" name="expression"/>
                  <Option value="3" type="int" name="type"/>
                </Option>
                <Option type="Map" name="enabled">
                  <Option value="true" type="bool" name="active"/>
                  <Option value="&quot;direction&quot; is not null" type="QString" name="expression"/>
                  <Option value="3" type="int" name="type"/>
                </Option>
              </Option>
              <Option value="collection" type="QString" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer class="SimpleMarker" pass="0" enabled="1" locked="0">
          <Option type="Map">
            <Option value="0" type="QString" name="angle"/>
            <Option value="square" type="QString" name="cap_style"/>
            <Option value="255,255,255,255" type="QString" name="color"/>
            <Option value="1" type="QString" name="horizontal_anchor_point"/>
            <Option value="bevel" type="QString" name="joinstyle"/>
            <Option value="circle" type="QString" name="name"/>
            <Option value="0,0" type="QString" name="offset"/>
            <Option value="3x:0,0,0,0,0,0" type="QString" name="offset_map_unit_scale"/>
            <Option value="MM" type="QString" name="offset_unit"/>
            <Option value="35,35,35,255" type="QString" name="outline_color"/>
            <Option value="solid" type="QString" name="outline_style"/>
            <Option value="0" type="QString" name="outline_width"/>
            <Option value="3x:0,0,0,0,0,0" type="QString" name="outline_width_map_unit_scale"/>
            <Option value="MM" type="QString" name="outline_width_unit"/>
            <Option value="diameter" type="QString" name="scale_method"/>
            <Option value="2" type="QString" name="size"/>
            <Option value="3x:0,0,0,0,0,0" type="QString" name="size_map_unit_scale"/>
            <Option value="MM" type="QString" name="size_unit"/>
            <Option value="1" type="QString" name="vertical_anchor_point"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" type="QString" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="angle">
                  <Option value="false" type="bool" name="active"/>
                  <Option value="1" type="int" name="type"/>
                  <Option value="" type="QString" name="val"/>
                </Option>
                <Option type="Map" name="enabled">
                  <Option value="true" type="bool" name="active"/>
                  <Option value="&quot;direction&quot; is null" type="QString" name="expression"/>
                  <Option value="3" type="int" name="type"/>
                </Option>
              </Option>
              <Option value="collection" type="QString" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer class="SimpleMarker" pass="3" enabled="1" locked="0">
          <Option type="Map">
            <Option value="0" type="QString" name="angle"/>
            <Option value="square" type="QString" name="cap_style"/>
            <Option value="0,0,0,255" type="QString" name="color"/>
            <Option value="1" type="QString" name="horizontal_anchor_point"/>
            <Option value="bevel" type="QString" name="joinstyle"/>
            <Option value="circle" type="QString" name="name"/>
            <Option value="0,0" type="QString" name="offset"/>
            <Option value="3x:0,0,0,0,0,0" type="QString" name="offset_map_unit_scale"/>
            <Option value="MM" type="QString" name="offset_unit"/>
            <Option value="35,35,35,255" type="QString" name="outline_color"/>
            <Option value="no" type="QString" name="outline_style"/>
            <Option value="0" type="QString" name="outline_width"/>
            <Option value="3x:0,0,0,0,0,0" type="QString" name="outline_width_map_unit_scale"/>
            <Option value="MM" type="QString" name="outline_width_unit"/>
            <Option value="diameter" type="QString" name="scale_method"/>
            <Option value="0.75" type="QString" name="size"/>
            <Option value="3x:0,0,0,0,0,0" type="QString" name="size_map_unit_scale"/>
            <Option value="MM" type="QString" name="size_unit"/>
            <Option value="1" type="QString" name="vertical_anchor_point"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" type="QString" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="angle">
                  <Option value="false" type="bool" name="active"/>
                  <Option value="1" type="int" name="type"/>
                  <Option value="" type="QString" name="val"/>
                </Option>
              </Option>
              <Option value="collection" type="QString" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol force_rhr="0" frame_rate="10" alpha="0.6" clip_to_extent="1" type="marker" name="2" is_animated="0">
        <data_defined_properties>
          <Option type="Map">
            <Option value="" type="QString" name="name"/>
            <Option name="properties"/>
            <Option value="collection" type="QString" name="type"/>
          </Option>
        </data_defined_properties>
        <layer class="SimpleMarker" pass="0" enabled="1" locked="0">
          <Option type="Map">
            <Option value="0" type="QString" name="angle"/>
            <Option value="square" type="QString" name="cap_style"/>
            <Option value="179,179,179,255" type="QString" name="color"/>
            <Option value="1" type="QString" name="horizontal_anchor_point"/>
            <Option value="bevel" type="QString" name="joinstyle"/>
            <Option value="quarter_circle" type="QString" name="name"/>
            <Option value="0,0" type="QString" name="offset"/>
            <Option value="3x:0,0,0,0,0,0" type="QString" name="offset_map_unit_scale"/>
            <Option value="MM" type="QString" name="offset_unit"/>
            <Option value="35,35,35,255" type="QString" name="outline_color"/>
            <Option value="solid" type="QString" name="outline_style"/>
            <Option value="0" type="QString" name="outline_width"/>
            <Option value="3x:0,0,0,0,0,0" type="QString" name="outline_width_map_unit_scale"/>
            <Option value="MM" type="QString" name="outline_width_unit"/>
            <Option value="diameter" type="QString" name="scale_method"/>
            <Option value="5" type="QString" name="size"/>
            <Option value="3x:0,0,0,0,0,0" type="QString" name="size_map_unit_scale"/>
            <Option value="MM" type="QString" name="size_unit"/>
            <Option value="1" type="QString" name="vertical_anchor_point"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" type="QString" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="angle">
                  <Option value="true" type="bool" name="active"/>
                  <Option value="&quot;direction&quot; + 45" type="QString" name="expression"/>
                  <Option value="3" type="int" name="type"/>
                </Option>
                <Option type="Map" name="enabled">
                  <Option value="true" type="bool" name="active"/>
                  <Option value="&quot;direction&quot; is not null" type="QString" name="expression"/>
                  <Option value="3" type="int" name="type"/>
                </Option>
              </Option>
              <Option value="collection" type="QString" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer class="SimpleMarker" pass="0" enabled="1" locked="0">
          <Option type="Map">
            <Option value="0" type="QString" name="angle"/>
            <Option value="square" type="QString" name="cap_style"/>
            <Option value="179,179,179,255" type="QString" name="color"/>
            <Option value="1" type="QString" name="horizontal_anchor_point"/>
            <Option value="bevel" type="QString" name="joinstyle"/>
            <Option value="circle" type="QString" name="name"/>
            <Option value="0,0" type="QString" name="offset"/>
            <Option value="3x:0,0,0,0,0,0" type="QString" name="offset_map_unit_scale"/>
            <Option value="MM" type="QString" name="offset_unit"/>
            <Option value="35,35,35,255" type="QString" name="outline_color"/>
            <Option value="solid" type="QString" name="outline_style"/>
            <Option value="0" type="QString" name="outline_width"/>
            <Option value="3x:0,0,0,0,0,0" type="QString" name="outline_width_map_unit_scale"/>
            <Option value="MM" type="QString" name="outline_width_unit"/>
            <Option value="diameter" type="QString" name="scale_method"/>
            <Option value="2" type="QString" name="size"/>
            <Option value="3x:0,0,0,0,0,0" type="QString" name="size_map_unit_scale"/>
            <Option value="MM" type="QString" name="size_unit"/>
            <Option value="1" type="QString" name="vertical_anchor_point"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" type="QString" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="angle">
                  <Option value="false" type="bool" name="active"/>
                  <Option value="1" type="int" name="type"/>
                  <Option value="" type="QString" name="val"/>
                </Option>
                <Option type="Map" name="enabled">
                  <Option value="true" type="bool" name="active"/>
                  <Option value="&quot;direction&quot; is null" type="QString" name="expression"/>
                  <Option value="3" type="int" name="type"/>
                </Option>
              </Option>
              <Option value="collection" type="QString" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer class="SimpleMarker" pass="1" enabled="1" locked="0">
          <Option type="Map">
            <Option value="0" type="QString" name="angle"/>
            <Option value="square" type="QString" name="cap_style"/>
            <Option value="0,0,0,255" type="QString" name="color"/>
            <Option value="1" type="QString" name="horizontal_anchor_point"/>
            <Option value="bevel" type="QString" name="joinstyle"/>
            <Option value="circle" type="QString" name="name"/>
            <Option value="0,0" type="QString" name="offset"/>
            <Option value="3x:0,0,0,0,0,0" type="QString" name="offset_map_unit_scale"/>
            <Option value="MM" type="QString" name="offset_unit"/>
            <Option value="35,35,35,255" type="QString" name="outline_color"/>
            <Option value="no" type="QString" name="outline_style"/>
            <Option value="0" type="QString" name="outline_width"/>
            <Option value="3x:0,0,0,0,0,0" type="QString" name="outline_width_map_unit_scale"/>
            <Option value="MM" type="QString" name="outline_width_unit"/>
            <Option value="diameter" type="QString" name="scale_method"/>
            <Option value="0.75" type="QString" name="size"/>
            <Option value="3x:0,0,0,0,0,0" type="QString" name="size_map_unit_scale"/>
            <Option value="MM" type="QString" name="size_unit"/>
            <Option value="1" type="QString" name="vertical_anchor_point"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" type="QString" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="angle">
                  <Option value="false" type="bool" name="active"/>
                  <Option value="1" type="int" name="type"/>
                  <Option value="" type="QString" name="val"/>
                </Option>
              </Option>
              <Option value="collection" type="QString" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </symbols>
  </renderer-v2>
  <labeling type="rule-based">
    <rules key="{f62d3984-d7d8-4db3-bbfd-b7a40e62f4c0}">
      <rule description="Photo" key="{f13a7fd1-424e-4abd-9113-ac6c870f3e26}" filter="/*&#xd;&#xa;写真表示地物かの条件判定　シンボロジ、ラベル共通&#xd;&#xa;*/&#xd;&#xa;with_variable('para',map(&#xd;&#xa; 'Number',  to_int( coalesce(@PhotoView_Number , 8) *if( @qgis_platform&lt;>'mobile',1,if( @map_extent_width > @map_extent_height ,1, @map_extent_width / @map_extent_height ))) ,&#xd;&#xa; 'TopMargin', to_real(coalesce(@PhotoView_TopMargin ,6.0)+if( @qgis_platform='mobile',3,0))*@map_scale/1000,&#xd;&#xa; 'SideMargin', if( @qgis_platform='mobile',9,1) * @map_scale / 1000,&#xd;&#xa; 'PhotoByGap', 15.0),&#xd;&#xa;with_variable('Gap',(@map_extent_width - @para['SideMargin']*2) /((@para['PhotoByGap']+1)*@para['Number']-1),&#xd;&#xa;with_variable('Extent',&#xd;&#xa;&#x9; intersection(  @map_extent , translate(  @map_extent ,0,-@para['PhotoByGap']*@Gap*0.800-@para['TopMargin'])),&#xd;&#xa;CASE &#xd;&#xa;WHEN  @map_rotation &lt;> 0 THEN false&#xd;&#xa;WHEN  attribute(  'invisible' ) THEN false&#xd;&#xa;WHEN  not within(   $geometry , @Extent )  THEN false&#xd;&#xa;ELSE&#xd;&#xa;with_variable('DistRank', array_find(&#xd;&#xa;&#x9; array_foreach(&#xd;&#xa;&#x9;array_sort( &#xd;&#xa;&#x9;&#x9;array_agg(  array(  distance(  @map_extent_center , $geometry ),$id  ) ,filter:=if( attribute(  'invisible' ),false,true) and within(   $geometry , @Extent ))&#xd;&#xa;&#x9;),&#xd;&#xa;&#x9;@element[1])&#xd;&#xa;&#x9;,$id),&#xd;&#xa;@DistRank&lt;@para['Number'])&#xd;&#xa;END&#xd;&#xa;)))">
        <settings calloutType="simple">
          <text-style fontSize="10" fontWeight="50" legendString="Aa" fontItalic="0" forcedItalic="0" forcedBold="0" fontKerning="1" previewBkgrdColor="255,255,255,255" isExpression="1" fieldName="coalesce(  attribute( 'label') , attribute('filename') ) " useSubstitutions="0" fontWordSpacing="0" textOrientation="horizontal" fontStrikeout="0" textOpacity="1" textColor="0,0,255,255" fontUnderline="0" fontSizeMapUnitScale="3x:0,0,0,0,0,0" blendMode="0" namedStyle="Regular" allowHtml="0" capitalization="0" fontLetterSpacing="0" fontFamily="Arial" multilineHeight="1" multilineHeightUnit="Percentage" fontSizeUnit="MapUnit">
            <families/>
            <text-buffer bufferNoFill="1" bufferDraw="1" bufferSizeUnits="MM" bufferJoinStyle="128" bufferColor="250,250,250,255" bufferSize="0.59999999999999998" bufferOpacity="1" bufferBlendMode="0" bufferSizeMapUnitScale="3x:0,0,0,0,0,0"/>
            <text-mask maskEnabled="0" maskType="0" maskOpacity="1" maskSizeMapUnitScale="3x:0,0,0,0,0,0" maskSize="0" maskSizeUnits="MM" maskJoinStyle="128" maskedSymbolLayers=""/>
            <background shapeOpacity="1" shapeBorderColor="128,128,128,255" shapeBlendMode="0" shapeBorderWidthUnit="Point" shapeType="0" shapeDraw="0" shapeOffsetUnit="Point" shapeSizeMapUnitScale="3x:0,0,0,0,0,0" shapeRadiiX="0" shapeSizeX="0" shapeRotationType="0" shapeBorderWidthMapUnitScale="3x:0,0,0,0,0,0" shapeRadiiMapUnitScale="3x:0,0,0,0,0,0" shapeSizeUnit="Point" shapeBorderWidth="0" shapeSizeType="0" shapeOffsetY="0" shapeOffsetMapUnitScale="3x:0,0,0,0,0,0" shapeSizeY="0" shapeSVGFile="" shapeRadiiY="0" shapeRadiiUnit="Point" shapeJoinStyle="64" shapeOffsetX="0" shapeRotation="0" shapeFillColor="255,255,255,255">
              <symbol force_rhr="0" frame_rate="10" alpha="1" clip_to_extent="1" type="marker" name="markerSymbol" is_animated="0">
                <data_defined_properties>
                  <Option type="Map">
                    <Option value="" type="QString" name="name"/>
                    <Option name="properties"/>
                    <Option value="collection" type="QString" name="type"/>
                  </Option>
                </data_defined_properties>
                <layer class="SimpleMarker" pass="0" enabled="1" locked="0">
                  <Option type="Map">
                    <Option value="0" type="QString" name="angle"/>
                    <Option value="square" type="QString" name="cap_style"/>
                    <Option value="243,166,178,255" type="QString" name="color"/>
                    <Option value="1" type="QString" name="horizontal_anchor_point"/>
                    <Option value="bevel" type="QString" name="joinstyle"/>
                    <Option value="circle" type="QString" name="name"/>
                    <Option value="0,0" type="QString" name="offset"/>
                    <Option value="3x:0,0,0,0,0,0" type="QString" name="offset_map_unit_scale"/>
                    <Option value="MM" type="QString" name="offset_unit"/>
                    <Option value="35,35,35,255" type="QString" name="outline_color"/>
                    <Option value="solid" type="QString" name="outline_style"/>
                    <Option value="0" type="QString" name="outline_width"/>
                    <Option value="3x:0,0,0,0,0,0" type="QString" name="outline_width_map_unit_scale"/>
                    <Option value="MM" type="QString" name="outline_width_unit"/>
                    <Option value="diameter" type="QString" name="scale_method"/>
                    <Option value="2" type="QString" name="size"/>
                    <Option value="3x:0,0,0,0,0,0" type="QString" name="size_map_unit_scale"/>
                    <Option value="MM" type="QString" name="size_unit"/>
                    <Option value="1" type="QString" name="vertical_anchor_point"/>
                  </Option>
                  <data_defined_properties>
                    <Option type="Map">
                      <Option value="" type="QString" name="name"/>
                      <Option name="properties"/>
                      <Option value="collection" type="QString" name="type"/>
                    </Option>
                  </data_defined_properties>
                </layer>
              </symbol>
              <symbol force_rhr="0" frame_rate="10" alpha="1" clip_to_extent="1" type="fill" name="fillSymbol" is_animated="0">
                <data_defined_properties>
                  <Option type="Map">
                    <Option value="" type="QString" name="name"/>
                    <Option name="properties"/>
                    <Option value="collection" type="QString" name="type"/>
                  </Option>
                </data_defined_properties>
                <layer class="SimpleFill" pass="0" enabled="1" locked="0">
                  <Option type="Map">
                    <Option value="3x:0,0,0,0,0,0" type="QString" name="border_width_map_unit_scale"/>
                    <Option value="255,255,255,255" type="QString" name="color"/>
                    <Option value="bevel" type="QString" name="joinstyle"/>
                    <Option value="0,0" type="QString" name="offset"/>
                    <Option value="3x:0,0,0,0,0,0" type="QString" name="offset_map_unit_scale"/>
                    <Option value="MM" type="QString" name="offset_unit"/>
                    <Option value="128,128,128,255" type="QString" name="outline_color"/>
                    <Option value="no" type="QString" name="outline_style"/>
                    <Option value="0" type="QString" name="outline_width"/>
                    <Option value="Point" type="QString" name="outline_width_unit"/>
                    <Option value="solid" type="QString" name="style"/>
                  </Option>
                  <data_defined_properties>
                    <Option type="Map">
                      <Option value="" type="QString" name="name"/>
                      <Option name="properties"/>
                      <Option value="collection" type="QString" name="type"/>
                    </Option>
                  </data_defined_properties>
                </layer>
              </symbol>
            </background>
            <shadow shadowOffsetUnit="MM" shadowDraw="0" shadowUnder="0" shadowOffsetAngle="135" shadowOffsetGlobal="1" shadowRadius="1.5" shadowColor="0,0,0,255" shadowBlendMode="6" shadowScale="100" shadowRadiusAlphaOnly="0" shadowOffsetDist="1" shadowRadiusMapUnitScale="3x:0,0,0,0,0,0" shadowRadiusUnit="MM" shadowOffsetMapUnitScale="3x:0,0,0,0,0,0" shadowOpacity="0.69999999999999996"/>
            <dd_properties>
              <Option type="Map">
                <Option value="" type="QString" name="name"/>
                <Option name="properties"/>
                <Option value="collection" type="QString" name="type"/>
              </Option>
            </dd_properties>
            <substitutions/>
          </text-style>
          <text-format placeDirectionSymbol="0" leftDirectionSymbol="&lt;" formatNumbers="0" wrapChar="" rightDirectionSymbol=">" reverseDirectionSymbol="0" plussign="0" decimals="3" useMaxLineLengthForAutoWrap="1" addDirectionSymbol="0" autoWrapLength="0" multilineAlign="3"/>
          <placement fitInPolygonOnly="0" distMapUnitScale="3x:0,0,0,0,0,0" preserveRotation="1" offsetType="1" layerType="PointGeometry" offsetUnits="MM" distUnits="MM" centroidInside="0" quadOffset="1" lineAnchorClipping="0" rotationUnit="AngleDegrees" geometryGenerator="/*&#xd;&#xa;ラスタ画像マーカーのアンカー位置、ラベルのアンカー位置　共通&#xd;&#xa;*/&#xd;&#xa;with_variable('para',map(&#xd;&#xa; 'Number',  to_int( coalesce(@PhotoView_Number , 8) *if( @qgis_platform&lt;>'mobile',1,if( @map_extent_width > @map_extent_height ,1, @map_extent_width / @map_extent_height ))) ,&#xd;&#xa; 'TopMargin', to_real(coalesce(@PhotoView_TopMargin ,6.0))*@map_scale/1000,&#xd;&#xa; 'SideMargin', if( @qgis_platform='mobile',9,1) * @map_scale / 1000,&#xd;&#xa; 'PhotoByGap', 15.0),&#xd;&#xa;with_variable('Gap',(@map_extent_width - @para['SideMargin']*2) /((@para['PhotoByGap']+1)*@para['Number']-1),&#xd;&#xa;with_variable('Extent',intersection(  @map_extent , translate(  @map_extent ,0,-@para['PhotoByGap']*@Gap*0.800-@para['TopMargin'])),&#xd;&#xa;with_variable('i',  --左から何番目か&#xd;&#xa; array_find(&#xd;&#xa;  array_foreach(&#xd;&#xa;    array_sort(&#xd;&#xa;&#x9; array_foreach( &#xd;&#xa;  &#x9;  array_slice(&#xd;&#xa;       array_sort( &#xd;&#xa;        array_agg(  array(  distance(  @map_extent_center , $geometry ),$id ,$x ) ,filter:=if( attribute(  'invisible' ),false,true) and within(   $geometry , @Extent ))&#xd;&#xa;        )&#xd;&#xa;      ,0,@para['Number']-1)&#xd;&#xa;&#x9;, array_reverse(@element))&#xd;&#xa;    )&#xd;&#xa;  ,@element[1])&#xd;&#xa; ,$id),&#x9;&#x9;-- i の定義終わり&#xd;&#xa; with_variable('p0',translate(@map_extent_center,@para['SideMargin']+(@para['PhotoByGap']/2)*@Gap-@map_extent_width/2,&#xd;&#xa;  @map_extent_height/2-@para['TopMargin']),&#xd;&#xa; translate(@p0,(1+@para['PhotoByGap'])*@Gap*@i,0)&#xd;&#xa;)))))&#xd;&#xa;" polygonPlacementFlags="2" centroidWhole="0" labelOffsetMapUnitScale="3x:0,0,0,0,0,0" lineAnchorTextPoint="CenterOfText" rotationAngle="0" overrunDistanceMapUnitScale="3x:0,0,0,0,0,0" maxCurvedCharAngleIn="25" overrunDistance="0" placement="1" lineAnchorType="0" repeatDistanceUnits="MM" geometryGeneratorEnabled="1" repeatDistanceMapUnitScale="3x:0,0,0,0,0,0" priority="5" overlapHandling="PreventOverlap" yOffset="0" predefinedPositionOrder="TR,TL,BR,BL,R,L,TSR,BSR" repeatDistance="0" dist="0" overrunDistanceUnit="MM" placementFlags="10" xOffset="0" lineAnchorPercent="0.5" maxCurvedCharAngleOut="-25" geometryGeneratorType="PointGeometry" allowDegraded="0"/>
          <rendering obstacle="1" obstacleType="1" zIndex="0" scaleVisibility="0" fontMinPixelSize="3" limitNumLabels="0" unplacedVisibility="0" maxNumLabels="2000" mergeLines="0" obstacleFactor="1" minFeatureSize="0" upsidedownLabels="0" scaleMin="0" scaleMax="0" drawLabels="1" fontLimitPixelSize="0" fontMaxPixelSize="10000" labelPerPart="0"/>
          <dd_properties>
            <Option type="Map">
              <Option value="" type="QString" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="Color">
                  <Option value="true" type="bool" name="active"/>
                  <Option value="darker( @PhotoView_Color,200)" type="QString" name="expression"/>
                  <Option value="3" type="int" name="type"/>
                </Option>
                <Option type="Map" name="Size">
                  <Option value="true" type="bool" name="active"/>
                  <Option value="/*&#xd;&#xa;ラベルの高さ&#xd;&#xa;文字数が多い場合、縮小する。&#xd;&#xa;プロポーショナルフォントは半角の幅が不定なので、幅を@SingleByteCaracterWidthで仮定する。&#xd;&#xa;*/&#xd;&#xa;&#xd;&#xa;with_variable('para',map(&#xd;&#xa; 'Number',  to_int( coalesce(@PhotoView_Number , 8) *if( @qgis_platform&lt;>'mobile',1,if( @map_extent_width > @map_extent_height ,1, @map_extent_width / @map_extent_height ))) ,&#xd;&#xa; 'TopMargin', to_real(coalesce(@PhotoView_TopMargin ,6.0)+if( @qgis_platform='mobile',3,0))*@map_scale/1000,&#xd;&#xa; 'SideMargin', if( @qgis_platform='mobile',9,1) * @map_scale / 1000,&#xd;&#xa; 'PhotoByGap', 15.0),&#xd;&#xa;with_variable('Gap',(@map_extent_width - @para['SideMargin']*2) /((@para['PhotoByGap']+1)*@para['Number']-1),&#xd;&#xa;with_variable('SingleByteCaracterWidth',to_real(coalesce(@PhotoView_SingleByteCaracterWidth ,0.7)),&#xd;&#xa;with_variable('LabelSize', @para['TopMargin']-if(@qgis_platform='mobile',4,1)*@map_scale/1000,&#xd;&#xa;with_variable('PhotoWidth',@para['PhotoByGap']*@Gap,&#xd;&#xa;with_variable('StrLen',&#xd;&#xa;    eval( array_to_string(&#xd;&#xa;    array_foreach(&#xd;&#xa;        array_remove_all( string_to_array(coalesce(  attribute( 'label') , attribute('filename') )   ,''),''),&#xd;&#xa;    if(@element ~ '[ -~]',@SingleByteCaracterWidth,1))&#xd;&#xa;,'+'))&#xd;&#xa;,&#xd;&#xa;if(@PhotoWidth>@LabelSize*@StrLen,&#xd;&#xa;    @LabelSize,@PhotoWidth/@StrLen)&#xd;&#xa;))))))" type="QString" name="expression"/>
                  <Option value="3" type="int" name="type"/>
                </Option>
              </Option>
              <Option value="collection" type="QString" name="type"/>
            </Option>
          </dd_properties>
          <callout type="simple">
            <Option type="Map">
              <Option value="pole_of_inaccessibility" type="QString" name="anchorPoint"/>
              <Option value="0" type="int" name="blendMode"/>
              <Option type="Map" name="ddProperties">
                <Option value="" type="QString" name="name"/>
                <Option name="properties"/>
                <Option value="collection" type="QString" name="type"/>
              </Option>
              <Option value="false" type="bool" name="drawToAllParts"/>
              <Option value="0" type="QString" name="enabled"/>
              <Option value="point_on_exterior" type="QString" name="labelAnchorPoint"/>
              <Option value="&lt;symbol force_rhr=&quot;0&quot; frame_rate=&quot;10&quot; alpha=&quot;1&quot; clip_to_extent=&quot;1&quot; type=&quot;line&quot; name=&quot;symbol&quot; is_animated=&quot;0&quot;>&lt;data_defined_properties>&lt;Option type=&quot;Map&quot;>&lt;Option value=&quot;&quot; type=&quot;QString&quot; name=&quot;name&quot;/>&lt;Option name=&quot;properties&quot;/>&lt;Option value=&quot;collection&quot; type=&quot;QString&quot; name=&quot;type&quot;/>&lt;/Option>&lt;/data_defined_properties>&lt;layer class=&quot;SimpleLine&quot; pass=&quot;0&quot; enabled=&quot;1&quot; locked=&quot;0&quot;>&lt;Option type=&quot;Map&quot;>&lt;Option value=&quot;0&quot; type=&quot;QString&quot; name=&quot;align_dash_pattern&quot;/>&lt;Option value=&quot;square&quot; type=&quot;QString&quot; name=&quot;capstyle&quot;/>&lt;Option value=&quot;5;2&quot; type=&quot;QString&quot; name=&quot;customdash&quot;/>&lt;Option value=&quot;3x:0,0,0,0,0,0&quot; type=&quot;QString&quot; name=&quot;customdash_map_unit_scale&quot;/>&lt;Option value=&quot;MM&quot; type=&quot;QString&quot; name=&quot;customdash_unit&quot;/>&lt;Option value=&quot;0&quot; type=&quot;QString&quot; name=&quot;dash_pattern_offset&quot;/>&lt;Option value=&quot;3x:0,0,0,0,0,0&quot; type=&quot;QString&quot; name=&quot;dash_pattern_offset_map_unit_scale&quot;/>&lt;Option value=&quot;MM&quot; type=&quot;QString&quot; name=&quot;dash_pattern_offset_unit&quot;/>&lt;Option value=&quot;0&quot; type=&quot;QString&quot; name=&quot;draw_inside_polygon&quot;/>&lt;Option value=&quot;bevel&quot; type=&quot;QString&quot; name=&quot;joinstyle&quot;/>&lt;Option value=&quot;60,60,60,255&quot; type=&quot;QString&quot; name=&quot;line_color&quot;/>&lt;Option value=&quot;solid&quot; type=&quot;QString&quot; name=&quot;line_style&quot;/>&lt;Option value=&quot;0.3&quot; type=&quot;QString&quot; name=&quot;line_width&quot;/>&lt;Option value=&quot;MM&quot; type=&quot;QString&quot; name=&quot;line_width_unit&quot;/>&lt;Option value=&quot;0&quot; type=&quot;QString&quot; name=&quot;offset&quot;/>&lt;Option value=&quot;3x:0,0,0,0,0,0&quot; type=&quot;QString&quot; name=&quot;offset_map_unit_scale&quot;/>&lt;Option value=&quot;MM&quot; type=&quot;QString&quot; name=&quot;offset_unit&quot;/>&lt;Option value=&quot;0&quot; type=&quot;QString&quot; name=&quot;ring_filter&quot;/>&lt;Option value=&quot;0&quot; type=&quot;QString&quot; name=&quot;trim_distance_end&quot;/>&lt;Option value=&quot;3x:0,0,0,0,0,0&quot; type=&quot;QString&quot; name=&quot;trim_distance_end_map_unit_scale&quot;/>&lt;Option value=&quot;MM&quot; type=&quot;QString&quot; name=&quot;trim_distance_end_unit&quot;/>&lt;Option value=&quot;0&quot; type=&quot;QString&quot; name=&quot;trim_distance_start&quot;/>&lt;Option value=&quot;3x:0,0,0,0,0,0&quot; type=&quot;QString&quot; name=&quot;trim_distance_start_map_unit_scale&quot;/>&lt;Option value=&quot;MM&quot; type=&quot;QString&quot; name=&quot;trim_distance_start_unit&quot;/>&lt;Option value=&quot;0&quot; type=&quot;QString&quot; name=&quot;tweak_dash_pattern_on_corners&quot;/>&lt;Option value=&quot;0&quot; type=&quot;QString&quot; name=&quot;use_custom_dash&quot;/>&lt;Option value=&quot;3x:0,0,0,0,0,0&quot; type=&quot;QString&quot; name=&quot;width_map_unit_scale&quot;/>&lt;/Option>&lt;data_defined_properties>&lt;Option type=&quot;Map&quot;>&lt;Option value=&quot;&quot; type=&quot;QString&quot; name=&quot;name&quot;/>&lt;Option name=&quot;properties&quot;/>&lt;Option value=&quot;collection&quot; type=&quot;QString&quot; name=&quot;type&quot;/>&lt;/Option>&lt;/data_defined_properties>&lt;/layer>&lt;/symbol>" type="QString" name="lineSymbol"/>
              <Option value="0" type="double" name="minLength"/>
              <Option value="3x:0,0,0,0,0,0" type="QString" name="minLengthMapUnitScale"/>
              <Option value="MM" type="QString" name="minLengthUnit"/>
              <Option value="0" type="double" name="offsetFromAnchor"/>
              <Option value="3x:0,0,0,0,0,0" type="QString" name="offsetFromAnchorMapUnitScale"/>
              <Option value="MM" type="QString" name="offsetFromAnchorUnit"/>
              <Option value="0" type="double" name="offsetFromLabel"/>
              <Option value="3x:0,0,0,0,0,0" type="QString" name="offsetFromLabelMapUnitScale"/>
              <Option value="MM" type="QString" name="offsetFromLabelUnit"/>
            </Option>
          </callout>
        </settings>
      </rule>
    </rules>
  </labeling>
  <blendMode>0</blendMode>
  <featureBlendMode>0</featureBlendMode>
  <fieldConfiguration>
    <field name="fid" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="photo" configurationFlags="None">
      <editWidget type="ExternalResource">
        <config>
          <Option type="Map">
            <Option value="1" type="int" name="DocumentViewer"/>
            <Option value="0" type="int" name="DocumentViewerHeight"/>
            <Option value="0" type="int" name="DocumentViewerWidth"/>
            <Option value="true" type="bool" name="FileWidget"/>
            <Option value="true" type="bool" name="FileWidgetButton"/>
            <Option value="" type="QString" name="FileWidgetFilter"/>
            <Option type="Map" name="PropertyCollection">
              <Option value="" type="QString" name="name"/>
              <Option type="invalid" name="properties"/>
              <Option value="collection" type="QString" name="type"/>
            </Option>
            <Option value="0" type="int" name="RelativeStorage"/>
            <Option value="" type="QString" name="StorageAuthConfigId"/>
            <Option value="0" type="int" name="StorageMode"/>
            <Option value="" type="QString" name="StorageType"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="filename" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="directory" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="altitude" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="direction" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="rotation" configurationFlags="None">
      <editWidget type="Range">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="longitude" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="latitude" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="timestamp" configurationFlags="None">
      <editWidget type="DateTime">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="invisible" configurationFlags="None">
      <editWidget type="CheckBox">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="label" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option/>
        </config>
      </editWidget>
    </field>
    <field name="relpath" configurationFlags="None">
      <editWidget type="ExternalResource">
        <config>
          <Option type="Map">
            <Option value="1" type="int" name="DocumentViewer"/>
            <Option value="0" type="int" name="DocumentViewerHeight"/>
            <Option value="0" type="int" name="DocumentViewerWidth"/>
            <Option value="true" type="bool" name="FileWidget"/>
            <Option value="true" type="bool" name="FileWidgetButton"/>
            <Option value="" type="QString" name="FileWidgetFilter"/>
            <Option type="Map" name="PropertyCollection">
              <Option value="" type="QString" name="name"/>
              <Option type="invalid" name="properties"/>
              <Option value="collection" type="QString" name="type"/>
            </Option>
            <Option value="1" type="int" name="RelativeStorage"/>
            <Option value="" type="QString" name="StorageAuthConfigId"/>
            <Option value="0" type="int" name="StorageMode"/>
            <Option value="" type="QString" name="StorageType"/>
          </Option>
        </config>
      </editWidget>
    </field>
  </fieldConfiguration>
  <aliases>
    <alias name="" field="fid" index="0"/>
    <alias name="" field="photo" index="1"/>
    <alias name="" field="filename" index="2"/>
    <alias name="" field="directory" index="3"/>
    <alias name="" field="altitude" index="4"/>
    <alias name="" field="direction" index="5"/>
    <alias name="" field="rotation" index="6"/>
    <alias name="" field="longitude" index="7"/>
    <alias name="" field="latitude" index="8"/>
    <alias name="" field="timestamp" index="9"/>
    <alias name="" field="invisible" index="10"/>
    <alias name="" field="label" index="11"/>
    <alias name="" field="relpath" index="12"/>
  </aliases>
  <defaults>
    <default expression="" applyOnUpdate="0" field="fid"/>
    <default expression="" applyOnUpdate="0" field="photo"/>
    <default expression="" applyOnUpdate="0" field="filename"/>
    <default expression="" applyOnUpdate="0" field="directory"/>
    <default expression="" applyOnUpdate="0" field="altitude"/>
    <default expression="" applyOnUpdate="0" field="direction"/>
    <default expression="" applyOnUpdate="0" field="rotation"/>
    <default expression="" applyOnUpdate="0" field="longitude"/>
    <default expression="" applyOnUpdate="0" field="latitude"/>
    <default expression="" applyOnUpdate="0" field="timestamp"/>
    <default expression="" applyOnUpdate="0" field="invisible"/>
    <default expression="" applyOnUpdate="0" field="label"/>
    <default expression="" applyOnUpdate="0" field="relpath"/>
  </defaults>
  <constraints>
    <constraint constraints="3" unique_strength="1" notnull_strength="1" field="fid" exp_strength="0"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" field="photo" exp_strength="0"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" field="filename" exp_strength="0"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" field="directory" exp_strength="0"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" field="altitude" exp_strength="0"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" field="direction" exp_strength="0"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" field="rotation" exp_strength="0"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" field="longitude" exp_strength="0"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" field="latitude" exp_strength="0"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" field="timestamp" exp_strength="0"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" field="invisible" exp_strength="0"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" field="label" exp_strength="0"/>
    <constraint constraints="0" unique_strength="0" notnull_strength="0" field="relpath" exp_strength="0"/>
  </constraints>
  <constraintExpressions>
    <constraint exp="" field="fid" desc=""/>
    <constraint exp="" field="photo" desc=""/>
    <constraint exp="" field="filename" desc=""/>
    <constraint exp="" field="directory" desc=""/>
    <constraint exp="" field="altitude" desc=""/>
    <constraint exp="" field="direction" desc=""/>
    <constraint exp="" field="rotation" desc=""/>
    <constraint exp="" field="longitude" desc=""/>
    <constraint exp="" field="latitude" desc=""/>
    <constraint exp="" field="timestamp" desc=""/>
    <constraint exp="" field="invisible" desc=""/>
    <constraint exp="" field="label" desc=""/>
    <constraint exp="" field="relpath" desc=""/>
  </constraintExpressions>
  <expressionfields/>
  <attributeactions>
    <defaultAction value="{f3d09ced-e2ce-4a35-956d-c1cb9c8ff1b8}" key="Canvas"/>
    <actionsetting action="[%replace(&#xd;&#xa; coalesce( attribute( 'photo'),&#xd;&#xa;  file_path( layer_property(  @layer ,'path')) || '/' || attribute('relpath')&#xd;&#xa; )&#xd;&#xa;, '\\','/')%]" capture="0" notificationMessage="" icon="" type="5" name="open" id="{f3d09ced-e2ce-4a35-956d-c1cb9c8ff1b8}" shortTitle="" isEnabledOnlyWhenEditable="0">
      <actionScope id="Field"/>
      <actionScope id="Layer"/>
      <actionScope id="Feature"/>
      <actionScope id="Canvas"/>
    </actionsetting>
  </attributeactions>
  <attributetableconfig actionWidgetStyle="dropDown" sortExpression="" sortOrder="0">
    <columns>
      <column type="field" hidden="0" name="filename" width="-1"/>
      <column type="field" hidden="0" name="directory" width="-1"/>
      <column type="field" hidden="0" name="altitude" width="-1"/>
      <column type="field" hidden="0" name="direction" width="-1"/>
      <column type="field" hidden="0" name="rotation" width="-1"/>
      <column type="field" hidden="0" name="longitude" width="-1"/>
      <column type="field" hidden="0" name="latitude" width="-1"/>
      <column type="field" hidden="0" name="timestamp" width="-1"/>
      <column type="field" hidden="0" name="invisible" width="-1"/>
      <column type="field" hidden="0" name="label" width="-1"/>
      <column type="field" hidden="0" name="relpath" width="231"/>
      <column type="field" hidden="0" name="fid" width="-1"/>
      <column type="field" hidden="0" name="photo" width="-1"/>
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
    <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
      <labelFont italic="0" style="" underline="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0" bold="0" strikethrough="0"/>
    </labelStyle>
    <attributeEditorField name="fid" showLabel="1" index="0">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont italic="0" style="" underline="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0" bold="0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="filename" showLabel="1" index="2">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont italic="0" style="" underline="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0" bold="0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="directory" showLabel="1" index="3">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont italic="0" style="" underline="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0" bold="0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="altitude" showLabel="1" index="4">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont italic="0" style="" underline="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0" bold="0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="direction" showLabel="1" index="5">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont italic="0" style="" underline="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0" bold="0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="rotation" showLabel="1" index="6">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont italic="0" style="" underline="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0" bold="0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="longitude" showLabel="1" index="7">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont italic="0" style="" underline="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0" bold="0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="latitude" showLabel="1" index="8">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont italic="0" style="" underline="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0" bold="0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="timestamp" showLabel="1" index="9">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont italic="0" style="" underline="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0" bold="0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="invisible" showLabel="1" index="10">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont italic="0" style="" underline="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0" bold="0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="label" showLabel="1" index="11">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont italic="0" style="" underline="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0" bold="0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="relpath" showLabel="1" index="12">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont italic="0" style="" underline="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0" bold="0" strikethrough="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer collapsedExpression="" visibilityExpressionEnabled="0" columnCount="2" groupBox="1" name="tttt" showLabel="1" collapsedExpressionEnabled="0" backgroundColor="#ff0000" collapsed="1" visibilityExpression="&quot;filename&quot;">
      <labelStyle overrideLabelColor="0" overrideLabelFont="0" labelColor="0,0,0,255">
        <labelFont italic="0" style="" underline="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0" bold="0" strikethrough="0"/>
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
    <field editable="1" name="photo"/>
    <field editable="1" name="relpath"/>
    <field editable="1" name="rotation"/>
    <field editable="1" name="timestamp"/>
  </editable>
  <labelOnTop>
    <field name="altitude" labelOnTop="0"/>
    <field name="direction" labelOnTop="0"/>
    <field name="directory" labelOnTop="0"/>
    <field name="fid" labelOnTop="0"/>
    <field name="filename" labelOnTop="0"/>
    <field name="invisible" labelOnTop="0"/>
    <field name="label" labelOnTop="0"/>
    <field name="latitude" labelOnTop="0"/>
    <field name="longitude" labelOnTop="0"/>
    <field name="photo" labelOnTop="0"/>
    <field name="relpath" labelOnTop="0"/>
    <field name="rotation" labelOnTop="0"/>
    <field name="timestamp" labelOnTop="0"/>
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
    <field reuseLastValue="0" name="photo"/>
    <field reuseLastValue="0" name="relpath"/>
    <field reuseLastValue="0" name="rotation"/>
    <field reuseLastValue="0" name="timestamp"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <layerGeometryType>0</layerGeometryType>
</qgis>
