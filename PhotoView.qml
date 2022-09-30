<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="Symbology|Labeling|Actions" labelsEnabled="1" version="3.16.16-Hannover">
  <renderer-v2 symbollevels="0" enableorderby="0" forceraster="0" type="RuleRenderer">
    <rules key="{4c83798d-3edf-4754-852c-330910c581ec}">
      <rule label="PHOTO" symbol="0" key="{580b1a51-0fff-4616-b191-d07f43f2f41a}" filter="/*&#xd;&#xa;写真表示地物かの条件判定　シンボロジ、ラベル共通&#xd;&#xa;*/&#xd;&#xa;with_variable('Number',  to_int( coalesce(@PhotoView_Number , 5) ) ,&#xd;&#xa;with_variable('TopMargin', to_real(coalesce(@PhotoView_TopMargin ,8.0))*@map_scale/1000,&#xd;&#xa;with_variable('PhotoBySideMargin',to_real(coalesce(@PhotoView_PhotoBySideMargin , 15.0)),&#xd;&#xa;with_variable('SideMargin',@map_extent_width /(1+(@PhotoBySideMargin+1)*@Number),&#xd;&#xa;with_variable('Extent',&#xd;&#xa;&#x9; intersection(  @map_extent , translate(  @map_extent ,0,-@PhotoBySideMargin*@SideMargin*0.800-@TopMargin)),&#xd;&#xa;CASE &#xd;&#xa;WHEN  @map_rotation &lt;> 0 THEN false&#xd;&#xa;WHEN  attribute(  'invisible' ) THEN false&#xd;&#xa;WHEN  not within(   $geometry , @Extent )  THEN false&#xd;&#xa;ELSE&#xd;&#xa;with_variable('DistRank', array_find(&#xd;&#xa;&#x9; array_foreach(&#xd;&#xa;&#x9;array_sort( &#xd;&#xa;&#x9;&#x9;array_agg(  array(  distance( @map_extent_center , $geometry ),$id  ) ,filter:=if( attribute(  'invisible' ),false,true) and within(   $geometry , @Extent ))&#xd;&#xa;&#x9;),&#xd;&#xa;&#x9;@element[1])&#xd;&#xa;&#x9;,$id),&#xd;&#xa;@DistRank&lt;@Number)&#xd;&#xa;END&#xd;&#xa;)))))"/>
      <rule label="far" symbol="1" key="{11dde42b-66f3-4248-b456-51b3af11524f}" filter="ELSE"/>
      <rule label="invisible" symbol="2" key="{3881f3a2-408f-4e64-84f6-d42475562fae}" filter="/*&#xd;&#xa;invisible フィールドがtrueの場合は写真表示から除外、アイコンはグレー&#xd;&#xa;*/&#xd;&#xa;  attribute( 'invisible' )&#xd;&#xa;&#xd;&#xa;/*&#xd;&#xa;photoview履歴・メモ,motohirooya&#xd;&#xa;2022/2/23　動くものができる&#xd;&#xa;2022/3/2&#xd;&#xa;・引き出し線を曲線（smooth）、引き出し線の起点をラスタ画像マーカと同じに。このため、@LEADER変数が不要に&#xd;&#xa;・invisibleフィールド（真偽値）を導入、値がtrueの場合は写真を非表示、それ以外（false,nll,フィールドが無い場合）は写真を表示）&#xd;&#xa;・photoview_inportモデル作成。invisibleフィールドの追加は属性リファクタリング（フィールド演算、フィールド追加では、真偽値が選べない。バージョンアップで「ジオタグ（位置情報）付きの写真」の出力がかわることに注意）&#xd;&#xa;・撮影位置を矢印から扇に変更&#xd;&#xa;2022/3/13 色の調整、コメントの記載&#xd;&#xa;2022/9/14 ラベルが衝突して表示されないことがあったので、プロジェクト変数に全角文字に対する半角文字の幅のパラメータを追加し、ラベルサイズの計算を行うよう変更（以前は0.66・・・の固定値を使用していた）&#xd;&#xa;ラベルサイズのプロジェクト変数を削除し、写真の上の余白-1mmを最大ラベルサイズとした。&#xd;&#xa;表示範囲外の地物は写真を表示しない条件を追加&#xd;&#xa;2022/9/19 写真と引き出し線が重ならないよう、写真を表示する上部はフィルタ範囲から除外（写真の縦横比は0.800を仮定）&#xd;&#xa;2022/9/23 label フィールド追加、値がある場合はラベルのフィールドとして使用&#xd;&#xa;2022/9/30 PhotoView_SingleByteCaracterWidth の既定値を0.8→0.7&#xd;&#xa;中心点との距離が同一の場合、順序がおかしくなる可能性があったのを修正&#xd;&#xa;labelフィールドがない場合、文字サイズの計算がおかしかったのを修正&#xd;&#xa;&#xd;&#xa;既知の問題&#xd;&#xa;・QGIS3.16では縦撮りの写真が横になる。QGIS3.22では縦になるがアンカー位置が写真の中間部になる（期待されるのは写真上部中央）&#xd;&#xa;・地図の回転には対応しない&#xd;&#xa;*/"/>
    </rules>
    <symbols>
      <symbol force_rhr="0" clip_to_extent="1" type="marker" alpha="0.6" name="0">
        <layer locked="0" enabled="1" class="GeometryGenerator" pass="6">
          <prop v="Line" k="SymbolType"/>
          <prop v="/*&#xd;&#xa;写真と撮影位置を結ぶライン 写真のアンカー位置を@piとし、一旦下に下げてから撮影位置と結ぶ&#xd;&#xa;*/&#xd;&#xa;&#xd;&#xa;with_variable('Number',  to_int( coalesce(@PhotoView_Number , 5) ) ,&#xd;&#xa;with_variable('TopMargin', to_real(coalesce(@PhotoView_TopMargin ,8.0))*@map_scale/1000,&#xd;&#xa;with_variable('PhotoBySideMargin',to_real(coalesce(@PhotoView_PhotoBySideMargin , 15.0)),&#xd;&#xa;with_variable('SideMargin',&#x9;@map_extent_width /(1+(@PhotoBySideMargin+1)*@Number),&#xd;&#xa;with_variable('Extent',intersection(  @map_extent , translate(  @map_extent ,0,-@PhotoBySideMargin*@SideMargin*0.800-@TopMargin)),&#xd;&#xa;with_variable('i',  --左から何番目か&#xd;&#xa; array_find(&#xd;&#xa;  array_foreach(&#xd;&#xa;    array_sort(&#xd;&#xa;&#x9; array_foreach( &#xd;&#xa;  &#x9;  array_slice(&#xd;&#xa;       array_sort( &#xd;&#xa;        array_agg(  array(  distance( @map_extent_center , $geometry ),$id ,$x ) ,filter:=if( attribute(  'invisible' ),false,true) and within(   $geometry , @Extent ))&#xd;&#xa;        )&#xd;&#xa;      ,0,@Number-1)&#xd;&#xa;&#x9;, array_reverse(@element))&#xd;&#xa;    )&#xd;&#xa;  ,@element[1])&#xd;&#xa; ,$id),&#x9;&#x9;-- i の定義終わり&#xd;&#xa;with_variable('p0',&#xd;&#xa;&#x9;translate(@map_extent_center,(1+@PhotoBySideMargin/2)*@SideMargin-@map_extent_width/2,&#xd;&#xa;&#x9;&#x9;@map_extent_height/2-@TopMargin),&#xd;&#xa;with_variable('pi',&#xd;&#xa;&#x9;translate(@p0,(1+@PhotoBySideMargin)*@SideMargin*@i,0),&#xd;&#xa;  smooth( make_line( @pi, make_point(x(@pi), (y(@pi)+y($geometry))/2 ) , $geometry  ) ,5 ) &#xd;&#xa;))))))))" k="geometryModifier"/>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" type="QString" name="name"/>
              <Option name="properties"/>
              <Option value="collection" type="QString" name="type"/>
            </Option>
          </data_defined_properties>
          <symbol force_rhr="0" clip_to_extent="1" type="line" alpha="1" name="@0@0">
            <layer locked="0" enabled="1" class="SimpleLine" pass="0">
              <prop v="0" k="align_dash_pattern"/>
              <prop v="square" k="capstyle"/>
              <prop v="5;2" k="customdash"/>
              <prop v="3x:0,0,0,0,0,0" k="customdash_map_unit_scale"/>
              <prop v="MM" k="customdash_unit"/>
              <prop v="0" k="dash_pattern_offset"/>
              <prop v="3x:0,0,0,0,0,0" k="dash_pattern_offset_map_unit_scale"/>
              <prop v="MM" k="dash_pattern_offset_unit"/>
              <prop v="0" k="draw_inside_polygon"/>
              <prop v="bevel" k="joinstyle"/>
              <prop v="15,245,245,255" k="line_color"/>
              <prop v="solid" k="line_style"/>
              <prop v="0.2" k="line_width"/>
              <prop v="MM" k="line_width_unit"/>
              <prop v="0" k="offset"/>
              <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
              <prop v="MM" k="offset_unit"/>
              <prop v="0" k="ring_filter"/>
              <prop v="0" k="tweak_dash_pattern_on_corners"/>
              <prop v="0" k="use_custom_dash"/>
              <prop v="3x:0,0,0,0,0,0" k="width_map_unit_scale"/>
              <data_defined_properties>
                <Option type="Map">
                  <Option value="" type="QString" name="name"/>
                  <Option name="properties"/>
                  <Option value="collection" type="QString" name="type"/>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </layer>
        <layer locked="0" enabled="1" class="SimpleMarker" pass="4">
          <prop v="0" k="angle"/>
          <prop v="15,245,245,255" k="color"/>
          <prop v="1" k="horizontal_anchor_point"/>
          <prop v="bevel" k="joinstyle"/>
          <prop v="quarter_circle" k="name"/>
          <prop v="0,0" k="offset"/>
          <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
          <prop v="MM" k="offset_unit"/>
          <prop v="35,35,35,255" k="outline_color"/>
          <prop v="solid" k="outline_style"/>
          <prop v="0.2" k="outline_width"/>
          <prop v="3x:0,0,0,0,0,0" k="outline_width_map_unit_scale"/>
          <prop v="MM" k="outline_width_unit"/>
          <prop v="diameter" k="scale_method"/>
          <prop v="5" k="size"/>
          <prop v="3x:0,0,0,0,0,0" k="size_map_unit_scale"/>
          <prop v="MM" k="size_unit"/>
          <prop v="1" k="vertical_anchor_point"/>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" type="QString" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="angle">
                  <Option value="true" type="bool" name="active"/>
                  <Option value="&quot;direction&quot; + 45" type="QString" name="expression"/>
                  <Option value="3" type="int" name="type"/>
                </Option>
              </Option>
              <Option value="collection" type="QString" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer locked="0" enabled="1" class="SimpleMarker" pass="5">
          <prop v="0" k="angle"/>
          <prop v="0,0,0,255" k="color"/>
          <prop v="1" k="horizontal_anchor_point"/>
          <prop v="bevel" k="joinstyle"/>
          <prop v="circle" k="name"/>
          <prop v="0,0" k="offset"/>
          <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
          <prop v="MM" k="offset_unit"/>
          <prop v="35,35,35,255" k="outline_color"/>
          <prop v="no" k="outline_style"/>
          <prop v="0" k="outline_width"/>
          <prop v="3x:0,0,0,0,0,0" k="outline_width_map_unit_scale"/>
          <prop v="MM" k="outline_width_unit"/>
          <prop v="diameter" k="scale_method"/>
          <prop v="0.6" k="size"/>
          <prop v="3x:0,0,0,0,0,0" k="size_map_unit_scale"/>
          <prop v="MM" k="size_unit"/>
          <prop v="1" k="vertical_anchor_point"/>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" type="QString" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="angle">
                  <Option value="true" type="bool" name="active"/>
                  <Option value="&quot;direction&quot; + 45" type="QString" name="expression"/>
                  <Option value="3" type="int" name="type"/>
                </Option>
              </Option>
              <Option value="collection" type="QString" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer locked="0" enabled="1" class="GeometryGenerator" pass="7">
          <prop v="Marker" k="SymbolType"/>
          <prop v="/*&#xd;&#xa;ラスタ画像マーカーのアンカー位置、ラベルのアンカー位置　共通&#xd;&#xa;*/&#xd;&#xa;with_variable('Number',  to_int( coalesce(@PhotoView_Number , 5) ) ,&#xd;&#xa;with_variable('TopMargin', to_real(coalesce(@PhotoView_TopMargin ,8.0))*@map_scale/1000,&#xd;&#xa;with_variable('PhotoBySideMargin',to_real(coalesce(@PhotoView_PhotoBySideMargin , 15.0)),&#xd;&#xa;with_variable('SideMargin',&#x9;@map_extent_width /(1+(@PhotoBySideMargin+1)*@Number),&#xd;&#xa;with_variable('Extent',intersection(  @map_extent , translate(  @map_extent ,0,-@PhotoBySideMargin*@SideMargin*0.800-@TopMargin)),&#xd;&#xa;with_variable('i',  --左から何番目か&#xd;&#xa; array_find(&#xd;&#xa;  array_foreach(&#xd;&#xa;    array_sort(&#xd;&#xa;&#x9; array_foreach( &#xd;&#xa;  &#x9;  array_slice(&#xd;&#xa;       array_sort( &#xd;&#xa;        array_agg(  array(  distance( @map_extent_center , $geometry ),$id ,$x ) ,filter:=if( attribute(  'invisible' ),false,true) and within(   $geometry , @Extent ))&#xd;&#xa;        )&#xd;&#xa;      ,0,@Number-1)&#xd;&#xa;&#x9;, array_reverse(@element))&#xd;&#xa;    )&#xd;&#xa;  ,@element[1])&#xd;&#xa; ,$id),&#x9;&#x9;-- i の定義終わり&#xd;&#xa; with_variable('p0',translate(@map_extent_center,(1+@PhotoBySideMargin/2)*@SideMargin-@map_extent_width/2,&#xd;&#xa;  @map_extent_height/2-@TopMargin),&#xd;&#xa; translate(@p0,(1+@PhotoBySideMargin)*@SideMargin*@i,0)&#xd;&#xa;)))))))&#xd;&#xa;" k="geometryModifier"/>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" type="QString" name="name"/>
              <Option name="properties"/>
              <Option value="collection" type="QString" name="type"/>
            </Option>
          </data_defined_properties>
          <symbol force_rhr="0" clip_to_extent="1" type="marker" alpha="1" name="@0@3">
            <layer locked="0" enabled="1" class="RasterMarker" pass="0">
              <prop v="1" k="alpha"/>
              <prop v="0" k="angle"/>
              <prop v="0" k="fixedAspectRatio"/>
              <prop v="1" k="horizontal_anchor_point"/>
              <prop v="" k="imageFile"/>
              <prop v="0,0" k="offset"/>
              <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
              <prop v="MM" k="offset_unit"/>
              <prop v="diameter" k="scale_method"/>
              <prop v="2" k="size"/>
              <prop v="3x:0,0,0,0,0,0" k="size_map_unit_scale"/>
              <prop v="MapUnit" k="size_unit"/>
              <prop v="0" k="vertical_anchor_point"/>
              <effect type="effectStack" enabled="1">
                <effect type="dropShadow">
                  <prop v="13" k="blend_mode"/>
                  <prop v="2.645" k="blur_level"/>
                  <prop v="MM" k="blur_unit"/>
                  <prop v="3x:0,0,0,0,0,0" k="blur_unit_scale"/>
                  <prop v="0,0,0,255" k="color"/>
                  <prop v="2" k="draw_mode"/>
                  <prop v="0" k="enabled"/>
                  <prop v="135" k="offset_angle"/>
                  <prop v="2" k="offset_distance"/>
                  <prop v="MM" k="offset_unit"/>
                  <prop v="3x:0,0,0,0,0,0" k="offset_unit_scale"/>
                  <prop v="1" k="opacity"/>
                </effect>
                <effect type="outerGlow">
                  <prop v="0" k="blend_mode"/>
                  <prop v="0.5" k="blur_level"/>
                  <prop v="MM" k="blur_unit"/>
                  <prop v="3x:0,0,0,0,0,0" k="blur_unit_scale"/>
                  <prop v="0,0,255,255" k="color1"/>
                  <prop v="0,255,0,255" k="color2"/>
                  <prop v="0" k="color_type"/>
                  <prop v="0" k="discrete"/>
                  <prop v="2" k="draw_mode"/>
                  <prop v="1" k="enabled"/>
                  <prop v="0.5" k="opacity"/>
                  <prop v="gradient" k="rampType"/>
                  <prop v="255,255,255,255" k="single_color"/>
                  <prop v="1" k="spread"/>
                  <prop v="MM" k="spread_unit"/>
                  <prop v="3x:0,0,0,0,0,0" k="spread_unit_scale"/>
                </effect>
                <effect type="drawSource">
                  <prop v="0" k="blend_mode"/>
                  <prop v="2" k="draw_mode"/>
                  <prop v="1" k="enabled"/>
                  <prop v="1" k="opacity"/>
                </effect>
                <effect type="innerShadow">
                  <prop v="13" k="blend_mode"/>
                  <prop v="2.645" k="blur_level"/>
                  <prop v="MM" k="blur_unit"/>
                  <prop v="3x:0,0,0,0,0,0" k="blur_unit_scale"/>
                  <prop v="0,0,0,255" k="color"/>
                  <prop v="2" k="draw_mode"/>
                  <prop v="0" k="enabled"/>
                  <prop v="135" k="offset_angle"/>
                  <prop v="2" k="offset_distance"/>
                  <prop v="MM" k="offset_unit"/>
                  <prop v="3x:0,0,0,0,0,0" k="offset_unit_scale"/>
                  <prop v="1" k="opacity"/>
                </effect>
                <effect type="innerGlow">
                  <prop v="0" k="blend_mode"/>
                  <prop v="2.645" k="blur_level"/>
                  <prop v="MM" k="blur_unit"/>
                  <prop v="3x:0,0,0,0,0,0" k="blur_unit_scale"/>
                  <prop v="0,0,255,255" k="color1"/>
                  <prop v="0,255,0,255" k="color2"/>
                  <prop v="0" k="color_type"/>
                  <prop v="0" k="discrete"/>
                  <prop v="2" k="draw_mode"/>
                  <prop v="0" k="enabled"/>
                  <prop v="0.5" k="opacity"/>
                  <prop v="gradient" k="rampType"/>
                  <prop v="255,255,255,255" k="single_color"/>
                  <prop v="2" k="spread"/>
                  <prop v="MM" k="spread_unit"/>
                  <prop v="3x:0,0,0,0,0,0" k="spread_unit_scale"/>
                </effect>
              </effect>
              <data_defined_properties>
                <Option type="Map">
                  <Option value="" type="QString" name="name"/>
                  <Option type="Map" name="properties">
                    <Option type="Map" name="name">
                      <Option value="true" type="bool" name="active"/>
                      <Option value="photo" type="QString" name="field"/>
                      <Option value="2" type="int" name="type"/>
                    </Option>
                    <Option type="Map" name="width">
                      <Option value="true" type="bool" name="active"/>
                      <Option value="with_variable('Number',if(@PhotoView_Number is null, to_int(5),to_int(@PhotoView_Number)),&#xd;&#xa;with_variable('TopMargin',if(@PhotoView_TopMargin is null, to_real(8)*@map_scale/1000,to_real(@PhotoView_TopMargin)*@map_scale/1000),&#xd;&#xa;with_variable('PhotoBySideMargin',if(@PhotoView_PhotoBySideMargin is null, to_real(15),to_real(@PhotoView_PhotoBySideMargin)),&#xd;&#xa;with_variable('SideMargin',&#xd;&#xa;&#x9;@map_extent_width /(1+(@PhotoBySideMargin+1)*@Number),&#xd;&#xa;&#x9;@PhotoBySideMargin*@SideMargin)&#xd;&#xa;)))" type="QString" name="expression"/>
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
      <symbol force_rhr="0" clip_to_extent="1" type="marker" alpha="0.6" name="1">
        <layer locked="0" enabled="1" class="SimpleMarker" pass="2">
          <prop v="0" k="angle"/>
          <prop v="255,255,255,255" k="color"/>
          <prop v="1" k="horizontal_anchor_point"/>
          <prop v="bevel" k="joinstyle"/>
          <prop v="quarter_circle" k="name"/>
          <prop v="0,0" k="offset"/>
          <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
          <prop v="MM" k="offset_unit"/>
          <prop v="35,35,35,255" k="outline_color"/>
          <prop v="solid" k="outline_style"/>
          <prop v="0" k="outline_width"/>
          <prop v="3x:0,0,0,0,0,0" k="outline_width_map_unit_scale"/>
          <prop v="MM" k="outline_width_unit"/>
          <prop v="diameter" k="scale_method"/>
          <prop v="5" k="size"/>
          <prop v="3x:0,0,0,0,0,0" k="size_map_unit_scale"/>
          <prop v="MM" k="size_unit"/>
          <prop v="1" k="vertical_anchor_point"/>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" type="QString" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="angle">
                  <Option value="true" type="bool" name="active"/>
                  <Option value="&quot;direction&quot; + 45" type="QString" name="expression"/>
                  <Option value="3" type="int" name="type"/>
                </Option>
              </Option>
              <Option value="collection" type="QString" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer locked="0" enabled="1" class="SimpleMarker" pass="3">
          <prop v="0" k="angle"/>
          <prop v="0,0,0,255" k="color"/>
          <prop v="1" k="horizontal_anchor_point"/>
          <prop v="bevel" k="joinstyle"/>
          <prop v="circle" k="name"/>
          <prop v="0,0" k="offset"/>
          <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
          <prop v="MM" k="offset_unit"/>
          <prop v="35,35,35,255" k="outline_color"/>
          <prop v="no" k="outline_style"/>
          <prop v="0" k="outline_width"/>
          <prop v="3x:0,0,0,0,0,0" k="outline_width_map_unit_scale"/>
          <prop v="MM" k="outline_width_unit"/>
          <prop v="diameter" k="scale_method"/>
          <prop v="0.75" k="size"/>
          <prop v="3x:0,0,0,0,0,0" k="size_map_unit_scale"/>
          <prop v="MM" k="size_unit"/>
          <prop v="1" k="vertical_anchor_point"/>
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
      <symbol force_rhr="0" clip_to_extent="1" type="marker" alpha="0.6" name="2">
        <layer locked="0" enabled="1" class="SimpleMarker" pass="0">
          <prop v="0" k="angle"/>
          <prop v="179,179,179,255" k="color"/>
          <prop v="1" k="horizontal_anchor_point"/>
          <prop v="bevel" k="joinstyle"/>
          <prop v="quarter_circle" k="name"/>
          <prop v="0,0" k="offset"/>
          <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
          <prop v="MM" k="offset_unit"/>
          <prop v="35,35,35,255" k="outline_color"/>
          <prop v="solid" k="outline_style"/>
          <prop v="0" k="outline_width"/>
          <prop v="3x:0,0,0,0,0,0" k="outline_width_map_unit_scale"/>
          <prop v="MM" k="outline_width_unit"/>
          <prop v="diameter" k="scale_method"/>
          <prop v="5" k="size"/>
          <prop v="3x:0,0,0,0,0,0" k="size_map_unit_scale"/>
          <prop v="MM" k="size_unit"/>
          <prop v="1" k="vertical_anchor_point"/>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" type="QString" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="angle">
                  <Option value="true" type="bool" name="active"/>
                  <Option value="&quot;direction&quot; + 45" type="QString" name="expression"/>
                  <Option value="3" type="int" name="type"/>
                </Option>
              </Option>
              <Option value="collection" type="QString" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer locked="0" enabled="1" class="SimpleMarker" pass="1">
          <prop v="0" k="angle"/>
          <prop v="0,0,0,255" k="color"/>
          <prop v="1" k="horizontal_anchor_point"/>
          <prop v="bevel" k="joinstyle"/>
          <prop v="circle" k="name"/>
          <prop v="0,0" k="offset"/>
          <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
          <prop v="MM" k="offset_unit"/>
          <prop v="35,35,35,255" k="outline_color"/>
          <prop v="no" k="outline_style"/>
          <prop v="0" k="outline_width"/>
          <prop v="3x:0,0,0,0,0,0" k="outline_width_map_unit_scale"/>
          <prop v="MM" k="outline_width_unit"/>
          <prop v="diameter" k="scale_method"/>
          <prop v="0.75" k="size"/>
          <prop v="3x:0,0,0,0,0,0" k="size_map_unit_scale"/>
          <prop v="MM" k="size_unit"/>
          <prop v="1" k="vertical_anchor_point"/>
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
    <rules key="{14a21547-54a0-4563-990e-4e93934f3c8e}">
      <rule description="Photo" key="{dfc5df32-22cb-4fa0-a8f8-a4e2ff4fde47}" filter="/*&#xd;&#xa;写真表示地物かの条件判定　シンボロジ、ラベル共通&#xd;&#xa;*/&#xd;&#xa;with_variable('Number',  to_int( coalesce(@PhotoView_Number , 5) ) ,&#xd;&#xa;with_variable('TopMargin', to_real(coalesce(@PhotoView_TopMargin ,8.0))*@map_scale/1000,&#xd;&#xa;with_variable('PhotoBySideMargin',to_real(coalesce(@PhotoView_PhotoBySideMargin , 15.0)),&#xd;&#xa;with_variable('SideMargin',@map_extent_width /(1+(@PhotoBySideMargin+1)*@Number),&#xd;&#xa;with_variable('Extent',&#xd;&#xa;&#x9; intersection(  @map_extent , translate(  @map_extent ,0,-@PhotoBySideMargin*@SideMargin*0.800-@TopMargin)),&#xd;&#xa;CASE &#xd;&#xa;WHEN  @map_rotation &lt;> 0 THEN false&#xd;&#xa;WHEN  attribute(  'invisible' ) THEN false&#xd;&#xa;WHEN  not within(   $geometry , @Extent )  THEN false&#xd;&#xa;ELSE&#xd;&#xa;with_variable('DistRank', array_find(&#xd;&#xa;&#x9; array_foreach(&#xd;&#xa;&#x9;array_sort( &#xd;&#xa;&#x9;&#x9;array_agg(  array(  distance( @map_extent_center , $geometry ),$id  ) ,filter:=if( attribute(  'invisible' ),false,true) and within(   $geometry , @Extent ))&#xd;&#xa;&#x9;),&#xd;&#xa;&#x9;@element[1])&#xd;&#xa;&#x9;,$id),&#xd;&#xa;@DistRank&lt;@Number)&#xd;&#xa;END&#xd;&#xa;)))))">
        <settings calloutType="simple">
          <text-style fontSize="10" textColor="0,0,0,255" fieldName=" coalesce(  attribute( 'label') , &quot;filename&quot; ) " fontItalic="0" fontKerning="1" fontUnderline="0" fontWeight="50" textOrientation="horizontal" multilineHeight="1" fontSizeUnit="MapUnit" textOpacity="1" blendMode="0" fontFamily="Arial" fontSizeMapUnitScale="3x:0,0,0,0,0,0" namedStyle="Regular" fontLetterSpacing="0" capitalization="0" fontStrikeout="0" previewBkgrdColor="255,255,255,255" fontWordSpacing="0" isExpression="1" useSubstitutions="0" allowHtml="0">
            <text-buffer bufferSizeMapUnitScale="3x:0,0,0,0,0,0" bufferSize="0.6" bufferColor="250,250,250,255" bufferDraw="1" bufferNoFill="1" bufferOpacity="1" bufferBlendMode="0" bufferSizeUnits="MM" bufferJoinStyle="128"/>
            <text-mask maskEnabled="0" maskJoinStyle="128" maskSizeUnits="MM" maskSizeMapUnitScale="3x:0,0,0,0,0,0" maskSize="0" maskOpacity="1" maskType="0" maskedSymbolLayers=""/>
            <background shapeOffsetMapUnitScale="3x:0,0,0,0,0,0" shapeBorderWidth="0" shapeRadiiUnit="Point" shapeBorderWidthUnit="Point" shapeOpacity="1" shapeBlendMode="0" shapeSVGFile="" shapeRotation="0" shapeOffsetUnit="Point" shapeType="0" shapeSizeY="0" shapeOffsetX="0" shapeRadiiY="0" shapeJoinStyle="64" shapeOffsetY="0" shapeBorderColor="128,128,128,255" shapeSizeUnit="Point" shapeDraw="0" shapeSizeMapUnitScale="3x:0,0,0,0,0,0" shapeRadiiX="0" shapeBorderWidthMapUnitScale="3x:0,0,0,0,0,0" shapeSizeX="0" shapeFillColor="255,255,255,255" shapeRotationType="0" shapeRadiiMapUnitScale="3x:0,0,0,0,0,0" shapeSizeType="0">
              <symbol force_rhr="0" clip_to_extent="1" type="marker" alpha="1" name="markerSymbol">
                <layer locked="0" enabled="1" class="SimpleMarker" pass="0">
                  <prop v="0" k="angle"/>
                  <prop v="243,166,178,255" k="color"/>
                  <prop v="1" k="horizontal_anchor_point"/>
                  <prop v="bevel" k="joinstyle"/>
                  <prop v="circle" k="name"/>
                  <prop v="0,0" k="offset"/>
                  <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
                  <prop v="MM" k="offset_unit"/>
                  <prop v="35,35,35,255" k="outline_color"/>
                  <prop v="solid" k="outline_style"/>
                  <prop v="0" k="outline_width"/>
                  <prop v="3x:0,0,0,0,0,0" k="outline_width_map_unit_scale"/>
                  <prop v="MM" k="outline_width_unit"/>
                  <prop v="diameter" k="scale_method"/>
                  <prop v="2" k="size"/>
                  <prop v="3x:0,0,0,0,0,0" k="size_map_unit_scale"/>
                  <prop v="MM" k="size_unit"/>
                  <prop v="1" k="vertical_anchor_point"/>
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
            <shadow shadowRadiusMapUnitScale="3x:0,0,0,0,0,0" shadowScale="100" shadowColor="0,0,0,255" shadowRadiusAlphaOnly="0" shadowOpacity="0.7" shadowRadiusUnit="MM" shadowUnder="0" shadowOffsetMapUnitScale="3x:0,0,0,0,0,0" shadowRadius="1.5" shadowOffsetDist="1" shadowBlendMode="6" shadowOffsetUnit="MM" shadowDraw="0" shadowOffsetAngle="135" shadowOffsetGlobal="1"/>
            <dd_properties>
              <Option type="Map">
                <Option value="" type="QString" name="name"/>
                <Option name="properties"/>
                <Option value="collection" type="QString" name="type"/>
              </Option>
            </dd_properties>
            <substitutions/>
          </text-style>
          <text-format plussign="0" wrapChar="" addDirectionSymbol="0" useMaxLineLengthForAutoWrap="1" formatNumbers="0" multilineAlign="3" leftDirectionSymbol="&lt;" rightDirectionSymbol=">" placeDirectionSymbol="0" autoWrapLength="0" reverseDirectionSymbol="0" decimals="3"/>
          <placement centroidInside="0" placement="1" repeatDistanceMapUnitScale="3x:0,0,0,0,0,0" repeatDistanceUnits="MM" lineAnchorPercent="0.5" preserveRotation="1" geometryGeneratorType="PointGeometry" quadOffset="1" fitInPolygonOnly="0" offsetType="1" overrunDistanceUnit="MM" distMapUnitScale="3x:0,0,0,0,0,0" placementFlags="10" distUnits="MM" labelOffsetMapUnitScale="3x:0,0,0,0,0,0" geometryGenerator="/*&#xd;&#xa;ラスタ画像マーカーのアンカー位置、ラベルのアンカー位置　共通&#xd;&#xa;*/&#xd;&#xa;with_variable('Number',  to_int( coalesce(@PhotoView_Number , 5) ) ,&#xd;&#xa;with_variable('TopMargin', to_real(coalesce(@PhotoView_TopMargin ,8.0))*@map_scale/1000,&#xd;&#xa;with_variable('PhotoBySideMargin',to_real(coalesce(@PhotoView_PhotoBySideMargin , 15.0)),&#xd;&#xa;with_variable('SideMargin',&#x9;@map_extent_width /(1+(@PhotoBySideMargin+1)*@Number),&#xd;&#xa;with_variable('Extent',intersection(  @map_extent , translate(  @map_extent ,0,-@PhotoBySideMargin*@SideMargin*0.800-@TopMargin)),&#xd;&#xa;with_variable('i',  --左から何番目か&#xd;&#xa; array_find(&#xd;&#xa;  array_foreach(&#xd;&#xa;    array_sort(&#xd;&#xa;&#x9; array_foreach( &#xd;&#xa;  &#x9;  array_slice(&#xd;&#xa;       array_sort( &#xd;&#xa;        array_agg(  array(  distance( @map_extent_center , $geometry ),$id ,$x ) ,filter:=if( attribute(  'invisible' ),false,true) and within(   $geometry , @Extent ))&#xd;&#xa;        )&#xd;&#xa;      ,0,@Number-1)&#xd;&#xa;&#x9;, array_reverse(@element))&#xd;&#xa;    )&#xd;&#xa;  ,@element[1])&#xd;&#xa; ,$id),&#x9;&#x9;-- i の定義終わり&#xd;&#xa; with_variable('p0',translate(@map_extent_center,(1+@PhotoBySideMargin/2)*@SideMargin-@map_extent_width/2,&#xd;&#xa;  @map_extent_height/2-@TopMargin),&#xd;&#xa; translate(@p0,(1+@PhotoBySideMargin)*@SideMargin*@i,0)&#xd;&#xa;)))))))&#xd;&#xa;" offsetUnits="MM" xOffset="0" predefinedPositionOrder="TR,TL,BR,BL,R,L,TSR,BSR" lineAnchorType="0" maxCurvedCharAngleIn="25" polygonPlacementFlags="2" overrunDistance="0" geometryGeneratorEnabled="1" priority="5" yOffset="0" overrunDistanceMapUnitScale="3x:0,0,0,0,0,0" layerType="PointGeometry" centroidWhole="0" maxCurvedCharAngleOut="-25" dist="0" rotationAngle="0" repeatDistance="0"/>
          <rendering displayAll="0" labelPerPart="0" fontMinPixelSize="3" maxNumLabels="2000" limitNumLabels="0" mergeLines="0" obstacleType="1" drawLabels="1" fontMaxPixelSize="10000" scaleVisibility="0" fontLimitPixelSize="0" scaleMin="0" zIndex="0" obstacleFactor="1" obstacle="1" upsidedownLabels="0" minFeatureSize="0" scaleMax="0"/>
          <dd_properties>
            <Option type="Map">
              <Option value="" type="QString" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="Size">
                  <Option value="true" type="bool" name="active"/>
                  <Option value="/*&#xd;&#xa;ラベルの高さ&#xd;&#xa;文字数が多い場合、縮小する。&#xd;&#xa;プロポーショナルフォントは半角の幅が不定なので、幅を@SingleByteCaracterWidthで仮定する。&#xd;&#xa;*/&#xd;&#xa;&#xd;&#xa;with_variable('Number',  to_int( coalesce(@PhotoView_Number , 5) ) ,&#xd;&#xa;with_variable('TopMargin', to_real(coalesce(@PhotoView_TopMargin ,8.0))*@map_scale/1000,&#xd;&#xa;with_variable('PhotoBySideMargin',to_real(coalesce(@PhotoView_PhotoBySideMargin , 15.0)),&#xd;&#xa;with_variable('SingleByteCaracterWidth',to_real(coalesce(@PhotoView_SingleByteCaracterWidth ,0.7)),&#xd;&#xa;with_variable('LabelSize',(@PhotoView_TopMargin-1)*@map_scale/1000,&#xd;&#xa;with_variable('SideMargin',&#xd;&#xa;    @map_extent_width /(1+(@PhotoBySideMargin+1)*@Number),&#xd;&#xa;with_variable('PhotoWidth',@PhotoBySideMargin*@SideMargin,&#xd;&#xa;with_variable('StrLen',&#xd;&#xa;    eval( array_to_string(&#xd;&#xa;    array_foreach(&#xd;&#xa;        array_remove_all( string_to_array(  coalesce(  attribute( 'label') , &quot;filename&quot; )  ,''),''),&#xd;&#xa;    if(@element ~ '[ -~]',@SingleByteCaracterWidth,1))&#xd;&#xa;,'+'))&#xd;&#xa;,&#xd;&#xa;if(@PhotoWidth>@LabelSize*@StrLen,&#xd;&#xa;    @LabelSize,@PhotoWidth/@StrLen)&#xd;&#xa;))))))))" type="QString" name="expression"/>
                  <Option value="3" type="int" name="type"/>
                </Option>
              </Option>
              <Option value="collection" type="QString" name="type"/>
            </Option>
          </dd_properties>
          <callout type="simple">
            <Option type="Map">
              <Option value="pole_of_inaccessibility" type="QString" name="anchorPoint"/>
              <Option type="Map" name="ddProperties">
                <Option value="" type="QString" name="name"/>
                <Option name="properties"/>
                <Option value="collection" type="QString" name="type"/>
              </Option>
              <Option value="false" type="bool" name="drawToAllParts"/>
              <Option value="0" type="QString" name="enabled"/>
              <Option value="point_on_exterior" type="QString" name="labelAnchorPoint"/>
              <Option value="&lt;symbol force_rhr=&quot;0&quot; clip_to_extent=&quot;1&quot; type=&quot;line&quot; alpha=&quot;1&quot; name=&quot;symbol&quot;>&lt;layer locked=&quot;0&quot; enabled=&quot;1&quot; class=&quot;SimpleLine&quot; pass=&quot;0&quot;>&lt;prop v=&quot;0&quot; k=&quot;align_dash_pattern&quot;/>&lt;prop v=&quot;square&quot; k=&quot;capstyle&quot;/>&lt;prop v=&quot;5;2&quot; k=&quot;customdash&quot;/>&lt;prop v=&quot;3x:0,0,0,0,0,0&quot; k=&quot;customdash_map_unit_scale&quot;/>&lt;prop v=&quot;MM&quot; k=&quot;customdash_unit&quot;/>&lt;prop v=&quot;0&quot; k=&quot;dash_pattern_offset&quot;/>&lt;prop v=&quot;3x:0,0,0,0,0,0&quot; k=&quot;dash_pattern_offset_map_unit_scale&quot;/>&lt;prop v=&quot;MM&quot; k=&quot;dash_pattern_offset_unit&quot;/>&lt;prop v=&quot;0&quot; k=&quot;draw_inside_polygon&quot;/>&lt;prop v=&quot;bevel&quot; k=&quot;joinstyle&quot;/>&lt;prop v=&quot;60,60,60,255&quot; k=&quot;line_color&quot;/>&lt;prop v=&quot;solid&quot; k=&quot;line_style&quot;/>&lt;prop v=&quot;0.3&quot; k=&quot;line_width&quot;/>&lt;prop v=&quot;MM&quot; k=&quot;line_width_unit&quot;/>&lt;prop v=&quot;0&quot; k=&quot;offset&quot;/>&lt;prop v=&quot;3x:0,0,0,0,0,0&quot; k=&quot;offset_map_unit_scale&quot;/>&lt;prop v=&quot;MM&quot; k=&quot;offset_unit&quot;/>&lt;prop v=&quot;0&quot; k=&quot;ring_filter&quot;/>&lt;prop v=&quot;0&quot; k=&quot;tweak_dash_pattern_on_corners&quot;/>&lt;prop v=&quot;0&quot; k=&quot;use_custom_dash&quot;/>&lt;prop v=&quot;3x:0,0,0,0,0,0&quot; k=&quot;width_map_unit_scale&quot;/>&lt;data_defined_properties>&lt;Option type=&quot;Map&quot;>&lt;Option value=&quot;&quot; type=&quot;QString&quot; name=&quot;name&quot;/>&lt;Option name=&quot;properties&quot;/>&lt;Option value=&quot;collection&quot; type=&quot;QString&quot; name=&quot;type&quot;/>&lt;/Option>&lt;/data_defined_properties>&lt;/layer>&lt;/symbol>" type="QString" name="lineSymbol"/>
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
  <attributeactions>
    <defaultAction value="{9701625d-c450-4b19-b80b-18aedc897aea}" key="Canvas"/>
    <actionsetting shortTitle="" id="{9701625d-c450-4b19-b80b-18aedc897aea}" notificationMessage="" capture="0" isEnabledOnlyWhenEditable="0" type="5" action="[%photo%]" name="open" icon="">
      <actionScope id="Canvas"/>
      <actionScope id="Feature"/>
      <actionScope id="Layer"/>
      <actionScope id="Field"/>
    </actionsetting>
  </attributeactions>
  <layerGeometryType>0</layerGeometryType>
</qgis>
