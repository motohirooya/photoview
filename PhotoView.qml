<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis labelsEnabled="1" styleCategories="Symbology|Labeling|Actions" version="3.22.9-Białowieża">
  <renderer-v2 type="RuleRenderer" referencescale="-1" enableorderby="0" symbollevels="0" forceraster="0">
    <rules key="{4c83798d-3edf-4754-852c-330910c581ec}">
      <rule filter="/*&#xd;&#xa;写真表示地物かの条件判定　シンボロジ、ラベル共通&#xd;&#xa;*/&#xd;&#xa;with_variable('Number',  to_int( coalesce(@PhotoView_Number , 5) ) ,&#xd;&#xa;with_variable('TopMargin', to_real(coalesce(@PhotoView_TopMargin ,8.0))*@map_scale/1000,&#xd;&#xa;with_variable('PhotoBySideMargin',to_real(coalesce(@PhotoView_PhotoBySideMargin , 15.0)),&#xd;&#xa;with_variable('SideMargin',@map_extent_width /(1+(@PhotoBySideMargin+1)*@Number),&#xd;&#xa;with_variable('Extent',&#xd;&#xa;&#x9; intersection(  @map_extent , translate(  @map_extent ,0,-@PhotoBySideMargin*@SideMargin*0.800-@TopMargin)),&#xd;&#xa;CASE &#xd;&#xa;WHEN  @map_rotation &lt;> 0 THEN false&#xd;&#xa;WHEN  attribute(  'invisible' ) THEN false&#xd;&#xa;WHEN  not within(   $geometry , @Extent )  THEN false&#xd;&#xa;ELSE&#xd;&#xa;with_variable('DistRank', array_find(&#xd;&#xa;&#x9; array_foreach(&#xd;&#xa;&#x9;array_sort( &#xd;&#xa;&#x9;&#x9;array_agg(  array(  distance( @map_extent_center , $geometry ),$id  ) ,filter:=if( attribute(  'invisible' ),false,true) and within(   $geometry , @Extent ))&#xd;&#xa;&#x9;),&#xd;&#xa;&#x9;@element[1])&#xd;&#xa;&#x9;,$id),&#xd;&#xa;@DistRank&lt;@Number)&#xd;&#xa;END&#xd;&#xa;)))))" key="{580b1a51-0fff-4616-b191-d07f43f2f41a}" symbol="0" label="PHOTO"/>
      <rule filter="ELSE" key="{11dde42b-66f3-4248-b456-51b3af11524f}" symbol="1" label="far"/>
      <rule filter="/*&#xd;&#xa;invisible フィールドがtrueの場合は写真表示から除外、アイコンはグレー&#xd;&#xa;*/&#xd;&#xa;  attribute( 'invisible' )&#xd;&#xa;&#xd;&#xa;/*&#xd;&#xa;photoview履歴・メモ,motohirooya&#xd;&#xa;2022/2/23　動くものができる&#xd;&#xa;2022/3/2&#xd;&#xa;・引き出し線を曲線（smooth）、引き出し線の起点をラスタ画像マーカと同じに。このため、@LEADER変数が不要に&#xd;&#xa;・invisibleフィールド（真偽値）を導入、値がtrueの場合は写真を非表示、それ以外（false,nll,フィールドが無い場合）は写真を表示）&#xd;&#xa;・photoview_inportモデル作成。invisibleフィールドの追加は属性リファクタリング（フィールド演算、フィールド追加では、真偽値が選べない。バージョンアップで「ジオタグ（位置情報）付きの写真」の出力がかわることに注意）&#xd;&#xa;・撮影位置を矢印から扇に変更&#xd;&#xa;2022/3/13 色の調整、コメントの記載&#xd;&#xa;2022/9/14 ラベルが衝突して表示されないことがあったので、プロジェクト変数に全角文字に対する半角文字の幅のパラメータを追加し、ラベルサイズの計算を行うよう変更（以前は0.66・・・の固定値を使用していた）&#xd;&#xa;ラベルサイズのプロジェクト変数を削除し、写真の上の余白-1mmを最大ラベルサイズとした。&#xd;&#xa;表示範囲外の地物は写真を表示しない条件を追加&#xd;&#xa;2022/9/19 写真と引き出し線が重ならないよう、写真を表示する上部はフィルタ範囲から除外（写真の縦横比は0.800を仮定）&#xd;&#xa;2022/9/23 label フィールド追加、値がある場合はラベルのフィールドとして使用&#xd;&#xa;&#xd;&#xa;既知の問題&#xd;&#xa;・QGIS3.16では縦撮りの写真が横になる。QGIS3.22では縦になるがアンカー位置が写真の中間部になる（期待されるのは写真上部中央）&#xd;&#xa;・地図の回転には対応しない&#xd;&#xa;*/" key="{3881f3a2-408f-4e64-84f6-d42475562fae}" symbol="2" label="invisible"/>
    </rules>
    <symbols>
      <symbol type="marker" clip_to_extent="1" force_rhr="0" name="0" alpha="0.6">
        <data_defined_properties>
          <Option type="Map">
            <Option type="QString" value="" name="name"/>
            <Option name="properties"/>
            <Option type="QString" value="collection" name="type"/>
          </Option>
        </data_defined_properties>
        <layer class="GeometryGenerator" pass="6" locked="0" enabled="1">
          <Option type="Map">
            <Option type="QString" value="Line" name="SymbolType"/>
            <Option type="QString" value="/*&#xd;&#xa;写真と撮影位置を結ぶライン 写真のアンカー位置を@piとし、一旦下に下げてから撮影位置と結ぶ&#xd;&#xa;*/&#xd;&#xa;&#xd;&#xa;with_variable('Number',  to_int( coalesce(@PhotoView_Number , 5) ) ,&#xd;&#xa;with_variable('TopMargin', to_real(coalesce(@PhotoView_TopMargin ,8.0))*@map_scale/1000,&#xd;&#xa;with_variable('PhotoBySideMargin',to_real(coalesce(@PhotoView_PhotoBySideMargin , 15.0)),&#xd;&#xa;with_variable('SideMargin',&#x9;@map_extent_width /(1+(@PhotoBySideMargin+1)*@Number),&#xd;&#xa;with_variable('Extent',intersection(  @map_extent , translate(  @map_extent ,0,-@PhotoBySideMargin*@SideMargin*0.800-@TopMargin)),&#xd;&#xa;with_variable('i',   array_find(&#xd;&#xa;                    array_foreach(&#xd;&#xa;                    array_sort(&#xd;&#xa;                    array_slice(&#xd;&#xa;                    array_agg(  array( $x, $id) ,order_by:=distance( @map_extent_center , $geometry ),filter:=if( attribute(  'invisible' ),false,true) and within(   $geometry , @Extent ))&#xd;&#xa;                    ,0,@Number-1)&#xd;&#xa;                    ),@element[1])&#xd;&#xa;                    ,$id),&#xd;&#xa;with_variable('p0',&#xd;&#xa;&#x9;translate(@map_extent_center,(1+@PhotoBySideMargin/2)*@SideMargin-@map_extent_width/2,&#xd;&#xa;&#x9;&#x9;@map_extent_height/2-@TopMargin),&#xd;&#xa;with_variable('pi',&#xd;&#xa;&#x9;translate(@p0,(1+@PhotoBySideMargin)*@SideMargin*@i,0),&#xd;&#xa;  smooth( make_line( @pi, make_point(x(@pi), (y(@pi)+y($geometry))/2 ) , $geometry  ) ,5 ) &#xd;&#xa;))))))))" name="geometryModifier"/>
            <Option type="QString" value="MapUnit" name="units"/>
          </Option>
          <prop v="Line" k="SymbolType"/>
          <prop v="/*&#xd;&#xa;写真と撮影位置を結ぶライン 写真のアンカー位置を@piとし、一旦下に下げてから撮影位置と結ぶ&#xd;&#xa;*/&#xd;&#xa;&#xd;&#xa;with_variable('Number',  to_int( coalesce(@PhotoView_Number , 5) ) ,&#xd;&#xa;with_variable('TopMargin', to_real(coalesce(@PhotoView_TopMargin ,8.0))*@map_scale/1000,&#xd;&#xa;with_variable('PhotoBySideMargin',to_real(coalesce(@PhotoView_PhotoBySideMargin , 15.0)),&#xd;&#xa;with_variable('SideMargin',&#x9;@map_extent_width /(1+(@PhotoBySideMargin+1)*@Number),&#xd;&#xa;with_variable('Extent',intersection(  @map_extent , translate(  @map_extent ,0,-@PhotoBySideMargin*@SideMargin*0.800-@TopMargin)),&#xd;&#xa;with_variable('i',   array_find(&#xd;&#xa;                    array_foreach(&#xd;&#xa;                    array_sort(&#xd;&#xa;                    array_slice(&#xd;&#xa;                    array_agg(  array( $x, $id) ,order_by:=distance( @map_extent_center , $geometry ),filter:=if( attribute(  'invisible' ),false,true) and within(   $geometry , @Extent ))&#xd;&#xa;                    ,0,@Number-1)&#xd;&#xa;                    ),@element[1])&#xd;&#xa;                    ,$id),&#xd;&#xa;with_variable('p0',&#xd;&#xa;&#x9;translate(@map_extent_center,(1+@PhotoBySideMargin/2)*@SideMargin-@map_extent_width/2,&#xd;&#xa;&#x9;&#x9;@map_extent_height/2-@TopMargin),&#xd;&#xa;with_variable('pi',&#xd;&#xa;&#x9;translate(@p0,(1+@PhotoBySideMargin)*@SideMargin*@i,0),&#xd;&#xa;  smooth( make_line( @pi, make_point(x(@pi), (y(@pi)+y($geometry))/2 ) , $geometry  ) ,5 ) &#xd;&#xa;))))))))" k="geometryModifier"/>
          <prop v="MapUnit" k="units"/>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" value="" name="name"/>
              <Option name="properties"/>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
          <symbol type="line" clip_to_extent="1" force_rhr="0" name="@0@0" alpha="1">
            <data_defined_properties>
              <Option type="Map">
                <Option type="QString" value="" name="name"/>
                <Option name="properties"/>
                <Option type="QString" value="collection" name="type"/>
              </Option>
            </data_defined_properties>
            <layer class="SimpleLine" pass="0" locked="0" enabled="1">
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
              <prop v="0" k="trim_distance_end"/>
              <prop v="3x:0,0,0,0,0,0" k="trim_distance_end_map_unit_scale"/>
              <prop v="MM" k="trim_distance_end_unit"/>
              <prop v="0" k="trim_distance_start"/>
              <prop v="3x:0,0,0,0,0,0" k="trim_distance_start_map_unit_scale"/>
              <prop v="MM" k="trim_distance_start_unit"/>
              <prop v="0" k="tweak_dash_pattern_on_corners"/>
              <prop v="0" k="use_custom_dash"/>
              <prop v="3x:0,0,0,0,0,0" k="width_map_unit_scale"/>
              <data_defined_properties>
                <Option type="Map">
                  <Option type="QString" value="" name="name"/>
                  <Option name="properties"/>
                  <Option type="QString" value="collection" name="type"/>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </layer>
        <layer class="SimpleMarker" pass="4" locked="0" enabled="1">
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
          <prop v="0" k="angle"/>
          <prop v="square" k="cap_style"/>
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
              <Option type="QString" value="" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="angle">
                  <Option type="bool" value="true" name="active"/>
                  <Option type="QString" value="&quot;direction&quot; + 45" name="expression"/>
                  <Option type="int" value="3" name="type"/>
                </Option>
              </Option>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer class="SimpleMarker" pass="5" locked="0" enabled="1">
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
          <prop v="0" k="angle"/>
          <prop v="square" k="cap_style"/>
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
              <Option type="QString" value="" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="angle">
                  <Option type="bool" value="true" name="active"/>
                  <Option type="QString" value="&quot;direction&quot; + 45" name="expression"/>
                  <Option type="int" value="3" name="type"/>
                </Option>
              </Option>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer class="GeometryGenerator" pass="7" locked="0" enabled="1">
          <Option type="Map">
            <Option type="QString" value="Marker" name="SymbolType"/>
            <Option type="QString" value="/*&#xd;&#xa;ラスタ画像マーカーのアンカー位置、ラベルのアンカー位置　共通&#xd;&#xa;*/&#xd;&#xa;with_variable('Number',  to_int( coalesce(@PhotoView_Number , 5) ) ,&#xd;&#xa;with_variable('TopMargin', to_real(coalesce(@PhotoView_TopMargin ,8.0))*@map_scale/1000,&#xd;&#xa;with_variable('PhotoBySideMargin',to_real(coalesce(@PhotoView_PhotoBySideMargin , 15.0)),&#xd;&#xa;with_variable('SideMargin',&#x9;@map_extent_width /(1+(@PhotoBySideMargin+1)*@Number),&#xd;&#xa;with_variable('Extent',intersection(  @map_extent , translate(  @map_extent ,0,-@PhotoBySideMargin*@SideMargin*0.800-@TopMargin)),&#xd;&#xa;with_variable('i',   array_find(&#xd;&#xa;                    array_foreach(&#xd;&#xa;                    array_sort(&#xd;&#xa;                    array_slice(&#xd;&#xa;                    array_agg(  array( $x, $id) ,order_by:=distance( @map_extent_center , $geometry ),filter:=if( attribute(  'invisible' ),false,true) and within(   $geometry , @Extent ))&#xd;&#xa;                    ,0,@Number-1)&#xd;&#xa;                    ),@element[1])&#xd;&#xa;                    ,$id),&#xd;&#xa;with_variable('p0',&#xd;&#xa;&#x9;translate(@map_extent_center,(1+@PhotoBySideMargin/2)*@SideMargin-@map_extent_width/2,&#xd;&#xa;&#x9;&#x9;@map_extent_height/2-@TopMargin),&#xd;&#xa;translate(@p0,(1+@PhotoBySideMargin)*@SideMargin*@i,0)&#xd;&#xa;)))))))&#xd;&#xa;" name="geometryModifier"/>
            <Option type="QString" value="MapUnit" name="units"/>
          </Option>
          <prop v="Marker" k="SymbolType"/>
          <prop v="/*&#xd;&#xa;ラスタ画像マーカーのアンカー位置、ラベルのアンカー位置　共通&#xd;&#xa;*/&#xd;&#xa;with_variable('Number',  to_int( coalesce(@PhotoView_Number , 5) ) ,&#xd;&#xa;with_variable('TopMargin', to_real(coalesce(@PhotoView_TopMargin ,8.0))*@map_scale/1000,&#xd;&#xa;with_variable('PhotoBySideMargin',to_real(coalesce(@PhotoView_PhotoBySideMargin , 15.0)),&#xd;&#xa;with_variable('SideMargin',&#x9;@map_extent_width /(1+(@PhotoBySideMargin+1)*@Number),&#xd;&#xa;with_variable('Extent',intersection(  @map_extent , translate(  @map_extent ,0,-@PhotoBySideMargin*@SideMargin*0.800-@TopMargin)),&#xd;&#xa;with_variable('i',   array_find(&#xd;&#xa;                    array_foreach(&#xd;&#xa;                    array_sort(&#xd;&#xa;                    array_slice(&#xd;&#xa;                    array_agg(  array( $x, $id) ,order_by:=distance( @map_extent_center , $geometry ),filter:=if( attribute(  'invisible' ),false,true) and within(   $geometry , @Extent ))&#xd;&#xa;                    ,0,@Number-1)&#xd;&#xa;                    ),@element[1])&#xd;&#xa;                    ,$id),&#xd;&#xa;with_variable('p0',&#xd;&#xa;&#x9;translate(@map_extent_center,(1+@PhotoBySideMargin/2)*@SideMargin-@map_extent_width/2,&#xd;&#xa;&#x9;&#x9;@map_extent_height/2-@TopMargin),&#xd;&#xa;translate(@p0,(1+@PhotoBySideMargin)*@SideMargin*@i,0)&#xd;&#xa;)))))))&#xd;&#xa;" k="geometryModifier"/>
          <prop v="MapUnit" k="units"/>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" value="" name="name"/>
              <Option name="properties"/>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
          <symbol type="marker" clip_to_extent="1" force_rhr="0" name="@0@3" alpha="1">
            <data_defined_properties>
              <Option type="Map">
                <Option type="QString" value="" name="name"/>
                <Option name="properties"/>
                <Option type="QString" value="collection" name="type"/>
              </Option>
            </data_defined_properties>
            <layer class="RasterMarker" pass="0" locked="0" enabled="1">
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
                  <Option type="Map">
                    <Option type="QString" value="0" name="blend_mode"/>
                    <Option type="QString" value="0.5" name="blur_level"/>
                    <Option type="QString" value="MM" name="blur_unit"/>
                    <Option type="QString" value="3x:0,0,0,0,0,0" name="blur_unit_scale"/>
                    <Option type="QString" value="0,0,255,255" name="color1"/>
                    <Option type="QString" value="0,255,0,255" name="color2"/>
                    <Option type="QString" value="0" name="color_type"/>
                    <Option type="QString" value="0" name="discrete"/>
                    <Option type="QString" value="2" name="draw_mode"/>
                    <Option type="QString" value="1" name="enabled"/>
                    <Option type="QString" value="0.5" name="opacity"/>
                    <Option type="QString" value="gradient" name="rampType"/>
                    <Option type="QString" value="255,255,255,255" name="single_color"/>
                    <Option type="QString" value="1" name="spread"/>
                    <Option type="QString" value="MM" name="spread_unit"/>
                    <Option type="QString" value="3x:0,0,0,0,0,0" name="spread_unit_scale"/>
                  </Option>
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
                  <Option type="Map">
                    <Option type="QString" value="0" name="blend_mode"/>
                    <Option type="QString" value="2" name="draw_mode"/>
                    <Option type="QString" value="1" name="enabled"/>
                    <Option type="QString" value="1" name="opacity"/>
                  </Option>
                  <prop v="0" k="blend_mode"/>
                  <prop v="2" k="draw_mode"/>
                  <prop v="1" k="enabled"/>
                  <prop v="1" k="opacity"/>
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
                  <Option type="Map">
                    <Option type="QString" value="0" name="blend_mode"/>
                    <Option type="QString" value="2.645" name="blur_level"/>
                    <Option type="QString" value="MM" name="blur_unit"/>
                    <Option type="QString" value="3x:0,0,0,0,0,0" name="blur_unit_scale"/>
                    <Option type="QString" value="0,0,255,255" name="color1"/>
                    <Option type="QString" value="0,255,0,255" name="color2"/>
                    <Option type="QString" value="0" name="color_type"/>
                    <Option type="QString" value="0" name="discrete"/>
                    <Option type="QString" value="2" name="draw_mode"/>
                    <Option type="QString" value="0" name="enabled"/>
                    <Option type="QString" value="0.5" name="opacity"/>
                    <Option type="QString" value="gradient" name="rampType"/>
                    <Option type="QString" value="255,255,255,255" name="single_color"/>
                    <Option type="QString" value="2" name="spread"/>
                    <Option type="QString" value="MM" name="spread_unit"/>
                    <Option type="QString" value="3x:0,0,0,0,0,0" name="spread_unit_scale"/>
                  </Option>
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
                  <Option type="QString" value="" name="name"/>
                  <Option type="Map" name="properties">
                    <Option type="Map" name="name">
                      <Option type="bool" value="true" name="active"/>
                      <Option type="QString" value="photo" name="field"/>
                      <Option type="int" value="2" name="type"/>
                    </Option>
                    <Option type="Map" name="width">
                      <Option type="bool" value="true" name="active"/>
                      <Option type="QString" value="with_variable('Number',if(@PhotoView_Number is null, to_int(5),to_int(@PhotoView_Number)),&#xd;&#xa;with_variable('TopMargin',if(@PhotoView_TopMargin is null, to_real(8)*@map_scale/1000,to_real(@PhotoView_TopMargin)*@map_scale/1000),&#xd;&#xa;with_variable('PhotoBySideMargin',if(@PhotoView_PhotoBySideMargin is null, to_real(15),to_real(@PhotoView_PhotoBySideMargin)),&#xd;&#xa;with_variable('SideMargin',&#xd;&#xa;&#x9;@map_extent_width /(1+(@PhotoBySideMargin+1)*@Number),&#xd;&#xa;&#x9;@PhotoBySideMargin*@SideMargin)&#xd;&#xa;)))" name="expression"/>
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
      <symbol type="marker" clip_to_extent="1" force_rhr="0" name="1" alpha="0.6">
        <data_defined_properties>
          <Option type="Map">
            <Option type="QString" value="" name="name"/>
            <Option name="properties"/>
            <Option type="QString" value="collection" name="type"/>
          </Option>
        </data_defined_properties>
        <layer class="SimpleMarker" pass="2" locked="0" enabled="1">
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
          <prop v="0" k="angle"/>
          <prop v="square" k="cap_style"/>
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
              <Option type="QString" value="" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="angle">
                  <Option type="bool" value="true" name="active"/>
                  <Option type="QString" value="&quot;direction&quot; + 45" name="expression"/>
                  <Option type="int" value="3" name="type"/>
                </Option>
              </Option>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer class="SimpleMarker" pass="3" locked="0" enabled="1">
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
          <prop v="0" k="angle"/>
          <prop v="square" k="cap_style"/>
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
      <symbol type="marker" clip_to_extent="1" force_rhr="0" name="2" alpha="0.6">
        <data_defined_properties>
          <Option type="Map">
            <Option type="QString" value="" name="name"/>
            <Option name="properties"/>
            <Option type="QString" value="collection" name="type"/>
          </Option>
        </data_defined_properties>
        <layer class="SimpleMarker" pass="0" locked="0" enabled="1">
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
          <prop v="0" k="angle"/>
          <prop v="square" k="cap_style"/>
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
              <Option type="QString" value="" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="angle">
                  <Option type="bool" value="true" name="active"/>
                  <Option type="QString" value="&quot;direction&quot; + 45" name="expression"/>
                  <Option type="int" value="3" name="type"/>
                </Option>
              </Option>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer class="SimpleMarker" pass="1" locked="0" enabled="1">
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
          <prop v="0" k="angle"/>
          <prop v="square" k="cap_style"/>
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
    <rules key="{c36a2dc7-e5a3-4e3e-84fc-7e2b67d70bfd}">
      <rule filter="/*&#xd;&#xa;写真表示地物かの条件判定　シンボロジ、ラベル共通&#xd;&#xa;*/&#xd;&#xa;with_variable('Number',  to_int( coalesce(@PhotoView_Number , 5) ) ,&#xd;&#xa;with_variable('TopMargin', to_real(coalesce(@PhotoView_TopMargin ,8.0))*@map_scale/1000,&#xd;&#xa;with_variable('PhotoBySideMargin',to_real(coalesce(@PhotoView_PhotoBySideMargin , 15.0)),&#xd;&#xa;with_variable('SideMargin',@map_extent_width /(1+(@PhotoBySideMargin+1)*@Number),&#xd;&#xa;with_variable('Extent',&#xd;&#xa;&#x9; intersection(  @map_extent , translate(  @map_extent ,0,-@PhotoBySideMargin*@SideMargin*0.800-@TopMargin)),&#xd;&#xa;CASE &#xd;&#xa;WHEN  @map_rotation &lt;> 0 THEN false&#xd;&#xa;WHEN  attribute(  'invisible' ) THEN false&#xd;&#xa;WHEN  not within(   $geometry , @Extent )  THEN false&#xd;&#xa;ELSE&#xd;&#xa;with_variable('DistRank', array_find(&#xd;&#xa;&#x9; array_foreach(&#xd;&#xa;&#x9;array_sort( &#xd;&#xa;&#x9;&#x9;array_agg(  array(  distance( @map_extent_center , $geometry ),$id  ) ,filter:=if( attribute(  'invisible' ),false,true) and within(   $geometry , @Extent ))&#xd;&#xa;&#x9;),&#xd;&#xa;&#x9;@element[1])&#xd;&#xa;&#x9;,$id),&#xd;&#xa;@DistRank&lt;@Number)&#xd;&#xa;END&#xd;&#xa;)))))" description="Photo" key="{3fc15377-6b1f-4d2c-8891-b1b289b6d9a7}">
        <settings calloutType="simple">
          <text-style fontSizeUnit="MapUnit" previewBkgrdColor="255,255,255,255" fontLetterSpacing="0" isExpression="1" fontUnderline="0" namedStyle="Regular" multilineHeight="1" fontSize="10" fieldName=" coalesce( &quot;label&quot; , &quot;filename&quot; ) " fontItalic="0" textOpacity="1" blendMode="0" fontKerning="1" useSubstitutions="0" fontFamily="Arial" capitalization="0" textOrientation="horizontal" fontWeight="50" fontStrikeout="0" fontSizeMapUnitScale="3x:0,0,0,0,0,0" fontWordSpacing="0" allowHtml="0" textColor="0,0,0,255" legendString="Aa">
            <families/>
            <text-buffer bufferSize="0.59999999999999998" bufferDraw="1" bufferOpacity="1" bufferSizeUnits="MM" bufferNoFill="1" bufferJoinStyle="128" bufferColor="250,250,250,255" bufferSizeMapUnitScale="3x:0,0,0,0,0,0" bufferBlendMode="0"/>
            <text-mask maskedSymbolLayers="" maskJoinStyle="128" maskSizeMapUnitScale="3x:0,0,0,0,0,0" maskEnabled="0" maskOpacity="1" maskSizeUnits="MM" maskSize="0" maskType="0"/>
            <background shapeRadiiUnit="Point" shapeType="0" shapeOpacity="1" shapeFillColor="255,255,255,255" shapeOffsetMapUnitScale="3x:0,0,0,0,0,0" shapeJoinStyle="64" shapeBlendMode="0" shapeSizeUnit="Point" shapeSizeX="0" shapeRotationType="0" shapeOffsetUnit="Point" shapeBorderWidth="0" shapeOffsetY="0" shapeRadiiX="0" shapeOffsetX="0" shapeRadiiY="0" shapeRotation="0" shapeSizeY="0" shapeRadiiMapUnitScale="3x:0,0,0,0,0,0" shapeSVGFile="" shapeSizeMapUnitScale="3x:0,0,0,0,0,0" shapeSizeType="0" shapeBorderColor="128,128,128,255" shapeBorderWidthUnit="Point" shapeBorderWidthMapUnitScale="3x:0,0,0,0,0,0" shapeDraw="0">
              <symbol type="marker" clip_to_extent="1" force_rhr="0" name="markerSymbol" alpha="1">
                <data_defined_properties>
                  <Option type="Map">
                    <Option type="QString" value="" name="name"/>
                    <Option name="properties"/>
                    <Option type="QString" value="collection" name="type"/>
                  </Option>
                </data_defined_properties>
                <layer class="SimpleMarker" pass="0" locked="0" enabled="1">
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
                  <prop v="0" k="angle"/>
                  <prop v="square" k="cap_style"/>
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
                      <Option type="QString" value="" name="name"/>
                      <Option name="properties"/>
                      <Option type="QString" value="collection" name="type"/>
                    </Option>
                  </data_defined_properties>
                </layer>
              </symbol>
              <symbol type="fill" clip_to_extent="1" force_rhr="0" name="fillSymbol" alpha="1">
                <data_defined_properties>
                  <Option type="Map">
                    <Option type="QString" value="" name="name"/>
                    <Option name="properties"/>
                    <Option type="QString" value="collection" name="type"/>
                  </Option>
                </data_defined_properties>
                <layer class="SimpleFill" pass="0" locked="0" enabled="1">
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
                  <prop v="3x:0,0,0,0,0,0" k="border_width_map_unit_scale"/>
                  <prop v="255,255,255,255" k="color"/>
                  <prop v="bevel" k="joinstyle"/>
                  <prop v="0,0" k="offset"/>
                  <prop v="3x:0,0,0,0,0,0" k="offset_map_unit_scale"/>
                  <prop v="MM" k="offset_unit"/>
                  <prop v="128,128,128,255" k="outline_color"/>
                  <prop v="no" k="outline_style"/>
                  <prop v="0" k="outline_width"/>
                  <prop v="Point" k="outline_width_unit"/>
                  <prop v="solid" k="style"/>
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
            <shadow shadowOffsetGlobal="1" shadowRadius="1.5" shadowUnder="0" shadowOffsetAngle="135" shadowRadiusUnit="MM" shadowOpacity="0.69999999999999996" shadowBlendMode="6" shadowOffsetMapUnitScale="3x:0,0,0,0,0,0" shadowColor="0,0,0,255" shadowDraw="0" shadowOffsetUnit="MM" shadowRadiusAlphaOnly="0" shadowRadiusMapUnitScale="3x:0,0,0,0,0,0" shadowScale="100" shadowOffsetDist="1"/>
            <dd_properties>
              <Option type="Map">
                <Option type="QString" value="" name="name"/>
                <Option name="properties"/>
                <Option type="QString" value="collection" name="type"/>
              </Option>
            </dd_properties>
            <substitutions/>
          </text-style>
          <text-format autoWrapLength="0" leftDirectionSymbol="&lt;" rightDirectionSymbol=">" placeDirectionSymbol="0" decimals="3" multilineAlign="3" formatNumbers="0" wrapChar="" plussign="0" useMaxLineLengthForAutoWrap="1" addDirectionSymbol="0" reverseDirectionSymbol="0"/>
          <placement placementFlags="10" maxCurvedCharAngleIn="25" offsetUnits="MM" placement="1" distUnits="MM" overrunDistanceMapUnitScale="3x:0,0,0,0,0,0" centroidWhole="0" priority="5" fitInPolygonOnly="0" lineAnchorType="0" quadOffset="1" maxCurvedCharAngleOut="-25" geometryGeneratorEnabled="1" geometryGeneratorType="PointGeometry" polygonPlacementFlags="2" offsetType="1" labelOffsetMapUnitScale="3x:0,0,0,0,0,0" distMapUnitScale="3x:0,0,0,0,0,0" centroidInside="0" preserveRotation="1" predefinedPositionOrder="TR,TL,BR,BL,R,L,TSR,BSR" lineAnchorClipping="0" geometryGenerator="/*&#xd;&#xa;ラスタ画像マーカーのアンカー位置、ラベルのアンカー位置　共通&#xd;&#xa;*/&#xd;&#xa;with_variable('Number',  to_int( coalesce(@PhotoView_Number , 5) ) ,&#xd;&#xa;with_variable('TopMargin', to_real(coalesce(@PhotoView_TopMargin ,8.0))*@map_scale/1000,&#xd;&#xa;with_variable('PhotoBySideMargin',to_real(coalesce(@PhotoView_PhotoBySideMargin , 15.0)),&#xd;&#xa;with_variable('SideMargin',&#x9;@map_extent_width /(1+(@PhotoBySideMargin+1)*@Number),&#xd;&#xa;with_variable('Extent',intersection(  @map_extent , translate(  @map_extent ,0,-@PhotoBySideMargin*@SideMargin*0.800-@TopMargin)),&#xd;&#xa;with_variable('i',   array_find(&#xd;&#xa;                    array_foreach(&#xd;&#xa;                    array_sort(&#xd;&#xa;                    array_slice(&#xd;&#xa;                    array_agg(  array( $x, $id) ,order_by:=distance( @map_extent_center , $geometry ),filter:=if( attribute(  'invisible' ),false,true) and within(   $geometry , @Extent ))&#xd;&#xa;                    ,0,@Number-1)&#xd;&#xa;                    ),@element[1])&#xd;&#xa;                    ,$id),&#xd;&#xa;with_variable('p0',&#xd;&#xa;&#x9;translate(@map_extent_center,(1+@PhotoBySideMargin/2)*@SideMargin-@map_extent_width/2,&#xd;&#xa;&#x9;&#x9;@map_extent_height/2-@TopMargin),&#xd;&#xa;translate(@p0,(1+@PhotoBySideMargin)*@SideMargin*@i,0)&#xd;&#xa;)))))))&#xd;&#xa;" rotationUnit="AngleDegrees" overrunDistance="0" rotationAngle="0" xOffset="0" yOffset="0" layerType="PointGeometry" repeatDistanceUnits="MM" lineAnchorPercent="0.5" dist="0" repeatDistance="0" repeatDistanceMapUnitScale="3x:0,0,0,0,0,0" overrunDistanceUnit="MM"/>
          <rendering upsidedownLabels="0" labelPerPart="0" limitNumLabels="0" drawLabels="1" unplacedVisibility="0" fontMaxPixelSize="10000" fontMinPixelSize="3" maxNumLabels="2000" displayAll="0" obstacleFactor="1" obstacle="1" zIndex="0" minFeatureSize="0" scaleMax="0" scaleMin="0" mergeLines="0" scaleVisibility="0" fontLimitPixelSize="0" obstacleType="1"/>
          <dd_properties>
            <Option type="Map">
              <Option type="QString" value="" name="name"/>
              <Option type="Map" name="properties">
                <Option type="Map" name="Size">
                  <Option type="bool" value="true" name="active"/>
                  <Option type="QString" value="/*&#xd;&#xa;ラベルの高さ&#xd;&#xa;文字数が多い場合、縮小する。&#xd;&#xa;プロポーショナルフォントは半角の幅が不定なので、幅を@SingleByteCaracterWidthで仮定する。&#xd;&#xa;*/&#xd;&#xa;&#xd;&#xa;with_variable('Number',  to_int( coalesce(@PhotoView_Number , 5) ) ,&#xd;&#xa;with_variable('TopMargin', to_real(coalesce(@PhotoView_TopMargin ,8.0))*@map_scale/1000,&#xd;&#xa;with_variable('PhotoBySideMargin',to_real(coalesce(@PhotoView_PhotoBySideMargin , 15.0)),&#xd;&#xa;with_variable('SingleByteCaracterWidth',to_real(coalesce(@PhotoView_SingleByteCaracterWidth ,0.800)),&#xd;&#xa;with_variable('LabelSize',(@PhotoView_TopMargin-1)*@map_scale/1000,&#xd;&#xa;with_variable('SideMargin',&#xd;&#xa;    @map_extent_width /(1+(@PhotoBySideMargin+1)*@Number),&#xd;&#xa;with_variable('PhotoWidth',@PhotoBySideMargin*@SideMargin,&#xd;&#xa;with_variable('StrLen',&#xd;&#xa;    eval( array_to_string(&#xd;&#xa;    array_foreach(&#xd;&#xa;        array_remove_all( string_to_array(  coalesce( &quot;label&quot; , &quot;filename&quot; )  ,''),''),&#xd;&#xa;    if(@element ~ '[ -~]',@SingleByteCaracterWidth,1))&#xd;&#xa;,'+'))&#xd;&#xa;,&#xd;&#xa;if(@PhotoWidth>@LabelSize*@StrLen,&#xd;&#xa;    @LabelSize,@PhotoWidth/@StrLen)&#xd;&#xa;))))))))" name="expression"/>
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
              <Option type="QString" value="&lt;symbol type=&quot;line&quot; clip_to_extent=&quot;1&quot; force_rhr=&quot;0&quot; name=&quot;symbol&quot; alpha=&quot;1&quot;>&lt;data_defined_properties>&lt;Option type=&quot;Map&quot;>&lt;Option type=&quot;QString&quot; value=&quot;&quot; name=&quot;name&quot;/>&lt;Option name=&quot;properties&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;collection&quot; name=&quot;type&quot;/>&lt;/Option>&lt;/data_defined_properties>&lt;layer class=&quot;SimpleLine&quot; pass=&quot;0&quot; locked=&quot;0&quot; enabled=&quot;1&quot;>&lt;Option type=&quot;Map&quot;>&lt;Option type=&quot;QString&quot; value=&quot;0&quot; name=&quot;align_dash_pattern&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;square&quot; name=&quot;capstyle&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;5;2&quot; name=&quot;customdash&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;3x:0,0,0,0,0,0&quot; name=&quot;customdash_map_unit_scale&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;MM&quot; name=&quot;customdash_unit&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;0&quot; name=&quot;dash_pattern_offset&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;3x:0,0,0,0,0,0&quot; name=&quot;dash_pattern_offset_map_unit_scale&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;MM&quot; name=&quot;dash_pattern_offset_unit&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;0&quot; name=&quot;draw_inside_polygon&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;bevel&quot; name=&quot;joinstyle&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;60,60,60,255&quot; name=&quot;line_color&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;solid&quot; name=&quot;line_style&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;0.3&quot; name=&quot;line_width&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;MM&quot; name=&quot;line_width_unit&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;0&quot; name=&quot;offset&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;3x:0,0,0,0,0,0&quot; name=&quot;offset_map_unit_scale&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;MM&quot; name=&quot;offset_unit&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;0&quot; name=&quot;ring_filter&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;0&quot; name=&quot;trim_distance_end&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;3x:0,0,0,0,0,0&quot; name=&quot;trim_distance_end_map_unit_scale&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;MM&quot; name=&quot;trim_distance_end_unit&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;0&quot; name=&quot;trim_distance_start&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;3x:0,0,0,0,0,0&quot; name=&quot;trim_distance_start_map_unit_scale&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;MM&quot; name=&quot;trim_distance_start_unit&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;0&quot; name=&quot;tweak_dash_pattern_on_corners&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;0&quot; name=&quot;use_custom_dash&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;3x:0,0,0,0,0,0&quot; name=&quot;width_map_unit_scale&quot;/>&lt;/Option>&lt;prop v=&quot;0&quot; k=&quot;align_dash_pattern&quot;/>&lt;prop v=&quot;square&quot; k=&quot;capstyle&quot;/>&lt;prop v=&quot;5;2&quot; k=&quot;customdash&quot;/>&lt;prop v=&quot;3x:0,0,0,0,0,0&quot; k=&quot;customdash_map_unit_scale&quot;/>&lt;prop v=&quot;MM&quot; k=&quot;customdash_unit&quot;/>&lt;prop v=&quot;0&quot; k=&quot;dash_pattern_offset&quot;/>&lt;prop v=&quot;3x:0,0,0,0,0,0&quot; k=&quot;dash_pattern_offset_map_unit_scale&quot;/>&lt;prop v=&quot;MM&quot; k=&quot;dash_pattern_offset_unit&quot;/>&lt;prop v=&quot;0&quot; k=&quot;draw_inside_polygon&quot;/>&lt;prop v=&quot;bevel&quot; k=&quot;joinstyle&quot;/>&lt;prop v=&quot;60,60,60,255&quot; k=&quot;line_color&quot;/>&lt;prop v=&quot;solid&quot; k=&quot;line_style&quot;/>&lt;prop v=&quot;0.3&quot; k=&quot;line_width&quot;/>&lt;prop v=&quot;MM&quot; k=&quot;line_width_unit&quot;/>&lt;prop v=&quot;0&quot; k=&quot;offset&quot;/>&lt;prop v=&quot;3x:0,0,0,0,0,0&quot; k=&quot;offset_map_unit_scale&quot;/>&lt;prop v=&quot;MM&quot; k=&quot;offset_unit&quot;/>&lt;prop v=&quot;0&quot; k=&quot;ring_filter&quot;/>&lt;prop v=&quot;0&quot; k=&quot;trim_distance_end&quot;/>&lt;prop v=&quot;3x:0,0,0,0,0,0&quot; k=&quot;trim_distance_end_map_unit_scale&quot;/>&lt;prop v=&quot;MM&quot; k=&quot;trim_distance_end_unit&quot;/>&lt;prop v=&quot;0&quot; k=&quot;trim_distance_start&quot;/>&lt;prop v=&quot;3x:0,0,0,0,0,0&quot; k=&quot;trim_distance_start_map_unit_scale&quot;/>&lt;prop v=&quot;MM&quot; k=&quot;trim_distance_start_unit&quot;/>&lt;prop v=&quot;0&quot; k=&quot;tweak_dash_pattern_on_corners&quot;/>&lt;prop v=&quot;0&quot; k=&quot;use_custom_dash&quot;/>&lt;prop v=&quot;3x:0,0,0,0,0,0&quot; k=&quot;width_map_unit_scale&quot;/>&lt;data_defined_properties>&lt;Option type=&quot;Map&quot;>&lt;Option type=&quot;QString&quot; value=&quot;&quot; name=&quot;name&quot;/>&lt;Option name=&quot;properties&quot;/>&lt;Option type=&quot;QString&quot; value=&quot;collection&quot; name=&quot;type&quot;/>&lt;/Option>&lt;/data_defined_properties>&lt;/layer>&lt;/symbol>" name="lineSymbol"/>
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
  <attributeactions>
    <defaultAction value="{00000000-0000-0000-0000-000000000000}" key="Canvas"/>
    <actionsetting capture="0" isEnabledOnlyWhenEditable="0" type="5" notificationMessage="" icon="" id="{9701625d-c450-4b19-b80b-18aedc897aea}" name="open" action="[%photo%]" shortTitle="">
      <actionScope id="Feature"/>
      <actionScope id="Layer"/>
      <actionScope id="Field"/>
      <actionScope id="Canvas"/>
    </actionsetting>
  </attributeactions>
  <layerGeometryType>0</layerGeometryType>
</qgis>
