<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis labelsEnabled="1" version="3.16.16-Hannover" styleCategories="Symbology|Labeling|Actions">
  <renderer-v2 symbollevels="0" enableorderby="0" type="RuleRenderer" forceraster="0">
    <rules key="{4c83798d-3edf-4754-852c-330910c581ec}">
      <rule key="{580b1a51-0fff-4616-b191-d07f43f2f41a}" symbol="0" label="PHOTO VIEW" filter="/*&#xd;&#xa;写真表示地物かの条件判定　シンボロジ、ラベル共通&#xd;&#xa;*/&#xd;&#xa;CASE &#xd;&#xa;WHEN  @map_rotation &lt;> 0 THEN false&#xd;&#xa;WHEN  attribute(  'invisible' ) THEN false&#xd;&#xa;WHEN  not within(   $geometry , @map_extent   )  THEN false&#xd;&#xa;ELSE&#xd;&#xa;with_variable('Number',if(@PhotoView_Number is null, to_int(5),to_int(@PhotoView_Number)),&#xd;&#xa;with_variable('DistRank',   array_find(&#xd;&#xa;&#x9; array_foreach( &#xd;&#xa;&#x9;array_sort( &#xd;&#xa;&#x9;&#x9;array_agg(  array(  distance( @map_extent_center , $geometry ),$id  ) ,filter:=if( attribute(  'invisible' ),false,true))&#xd;&#xa;&#x9;),&#xd;&#xa;&#x9;@element[1])&#xd;&#xa;&#x9;,$id),&#xd;&#xa;@DistRank&lt;@Number)&#xd;&#xa;)&#xd;&#xa;END"/>
      <rule key="{11dde42b-66f3-4248-b456-51b3af11524f}" symbol="1" label="POINT" filter="ELSE"/>
      <rule key="{3881f3a2-408f-4e64-84f6-d42475562fae}" symbol="2" label="POINT" filter="/*&#xd;&#xa;invisible フィールドがtrueの場合は写真表示から除外、アイコンはグレー&#xd;&#xa;*/&#xd;&#xa;  attribute( 'invisible' )&#xd;&#xa;&#xd;&#xa;/*&#xd;&#xa;photoview履歴・メモ,motohirooya&#xd;&#xa;2022/2/23　動くものができる&#xd;&#xa;2022/3/2&#xd;&#xa;・引き出し線を曲線（smooth）、引き出し線の起点をラスタ画像マーカと同じに。このため、@LEADER変数が不要に&#xd;&#xa;・invisibleフィールド（真偽値）を導入、値がtrueの場合は写真を非表示、それ以外（false,nll,フィールドが無い場合）は写真を表示）&#xd;&#xa;・photoview_inportモデル作成。invisibleフィールドの追加は属性リファクタリング（フィールド演算、フィールド追加では、真偽値が選べない。バージョンアップで「ジオタグ（位置情報）付きの写真」の出力がかわることに注意）&#xd;&#xa;・撮影位置を矢印から扇に変更&#xd;&#xa;2022/3/13 色の調整、コメントの記載&#xd;&#xa;2022/9/14 ラベルが衝突して表示されないことがあったので、プロジェクト変数に全角文字に対する半角文字の幅のパラメータを追加し、ラベルサイズの計算を行うよう変更（以前は0.66・・・の固定値を使用していた）&#xd;&#xa;ラベルサイズのプロジェクト変数を削除し、写真の上の余白-1mmを最大ラベルサイズとした。&#xd;&#xa;表示範囲外の地物は写真を表示しない条件を追加&#xd;&#xa;&#xd;&#xa;既知の問題&#xd;&#xa;・QGIS3.16では縦撮りの写真が横になる。QGIS3.22では縦になるがアンカー位置が写真の中間部になる（期待されるのは写真上部中央）&#xd;&#xa;・地図の回転には対応しない&#xd;&#xa;*/"/>
    </rules>
    <symbols>
      <symbol clip_to_extent="1" alpha="0.6" name="0" force_rhr="0" type="marker">
        <layer class="GeometryGenerator" enabled="1" locked="0" pass="6">
          <prop k="SymbolType" v="Line"/>
          <prop k="geometryModifier" v="/*&#xd;&#xa;写真と撮影位置を結ぶライン 写真のアンカー位置を@piとし、一旦下に下げてから撮影位置と結ぶ&#xd;&#xa;*/&#xd;&#xa;&#xd;&#xa;with_variable('Number',if(@PhotoView_Number is null, to_int(5),to_int(@PhotoView_Number)),&#xd;&#xa;with_variable('TopMargin',if(@PhotoView_TopMargin is null, to_real(8)*@map_scale/1000,to_real(@PhotoView_TopMargin)*@map_scale/1000),&#xd;&#xa;with_variable('PhotoBySideMargin',if(@PhotoView_PhotoBySideMargin is null, to_real(15),to_real(@PhotoView_PhotoBySideMargin)),&#xd;&#xa;with_variable('SideMargin',&#x9;@map_extent_width /(1+(@PhotoBySideMargin+1)*@Number),&#xd;&#xa;with_variable('i',   array_find(&#xd;&#xa;                    array_foreach(&#xd;&#xa;                    array_sort(&#xd;&#xa;                    array_slice(&#xd;&#xa;                    array_agg(  array( $x, $id) ,order_by:=distance( @map_extent_center , $geometry ),filter:=if( attribute(  'invisible' ),false,true))&#xd;&#xa;                    ,0,@Number-1)&#xd;&#xa;                    ),@element[1])&#xd;&#xa;                    ,$id),&#xd;&#xa;with_variable('p0',&#xd;&#xa;&#x9;translate(@map_extent_center,(1+@PhotoBySideMargin/2)*@SideMargin-@map_extent_width/2,&#xd;&#xa;&#x9;&#x9;@map_extent_height/2-@TopMargin),&#xd;&#xa;with_variable('pi',&#xd;&#xa;&#x9;translate(@p0,(1+@PhotoBySideMargin)*@SideMargin*@i,0),&#xd;&#xa;  smooth( make_line( @pi, make_point(x(@pi), (y(@pi)+y($geometry))/2 ) , $geometry  ) ,5 ) &#xd;&#xa;)))))))&#xd;&#xa;"/>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" name="name" type="QString"/>
              <Option name="properties"/>
              <Option value="collection" name="type" type="QString"/>
            </Option>
          </data_defined_properties>
          <symbol clip_to_extent="1" alpha="1" name="@0@0" force_rhr="0" type="line">
            <layer class="SimpleLine" enabled="1" locked="0" pass="0">
              <prop k="align_dash_pattern" v="0"/>
              <prop k="capstyle" v="square"/>
              <prop k="customdash" v="5;2"/>
              <prop k="customdash_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="customdash_unit" v="MM"/>
              <prop k="dash_pattern_offset" v="0"/>
              <prop k="dash_pattern_offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="dash_pattern_offset_unit" v="MM"/>
              <prop k="draw_inside_polygon" v="0"/>
              <prop k="joinstyle" v="bevel"/>
              <prop k="line_color" v="15,245,245,255"/>
              <prop k="line_style" v="solid"/>
              <prop k="line_width" v="0.2"/>
              <prop k="line_width_unit" v="MM"/>
              <prop k="offset" v="0"/>
              <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="offset_unit" v="MM"/>
              <prop k="ring_filter" v="0"/>
              <prop k="tweak_dash_pattern_on_corners" v="0"/>
              <prop k="use_custom_dash" v="0"/>
              <prop k="width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <data_defined_properties>
                <Option type="Map">
                  <Option value="" name="name" type="QString"/>
                  <Option name="properties"/>
                  <Option value="collection" name="type" type="QString"/>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </layer>
        <layer class="SimpleMarker" enabled="1" locked="0" pass="4">
          <prop k="angle" v="0"/>
          <prop k="color" v="15,245,245,255"/>
          <prop k="horizontal_anchor_point" v="1"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="name" v="quarter_circle"/>
          <prop k="offset" v="0,0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="outline_color" v="35,35,35,255"/>
          <prop k="outline_style" v="solid"/>
          <prop k="outline_width" v="0.2"/>
          <prop k="outline_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="scale_method" v="diameter"/>
          <prop k="size" v="5"/>
          <prop k="size_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="size_unit" v="MM"/>
          <prop k="vertical_anchor_point" v="1"/>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" name="name" type="QString"/>
              <Option name="properties" type="Map">
                <Option name="angle" type="Map">
                  <Option value="true" name="active" type="bool"/>
                  <Option value="&quot;direction&quot; + 45" name="expression" type="QString"/>
                  <Option value="3" name="type" type="int"/>
                </Option>
              </Option>
              <Option value="collection" name="type" type="QString"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer class="SimpleMarker" enabled="1" locked="0" pass="5">
          <prop k="angle" v="0"/>
          <prop k="color" v="0,0,0,255"/>
          <prop k="horizontal_anchor_point" v="1"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="name" v="circle"/>
          <prop k="offset" v="0,0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="outline_color" v="35,35,35,255"/>
          <prop k="outline_style" v="no"/>
          <prop k="outline_width" v="0"/>
          <prop k="outline_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="scale_method" v="diameter"/>
          <prop k="size" v="0.6"/>
          <prop k="size_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="size_unit" v="MM"/>
          <prop k="vertical_anchor_point" v="1"/>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" name="name" type="QString"/>
              <Option name="properties" type="Map">
                <Option name="angle" type="Map">
                  <Option value="true" name="active" type="bool"/>
                  <Option value="&quot;direction&quot; + 45" name="expression" type="QString"/>
                  <Option value="3" name="type" type="int"/>
                </Option>
              </Option>
              <Option value="collection" name="type" type="QString"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer class="GeometryGenerator" enabled="1" locked="0" pass="7">
          <prop k="SymbolType" v="Marker"/>
          <prop k="geometryModifier" v="/*&#xd;&#xa;ラスタ画像マーカーのアンカー位置、ラベルのアンカー位置　共通&#xd;&#xa;*/&#xd;&#xa;with_variable('Number',if(@PhotoView_Number is null, to_int(5),to_int(@PhotoView_Number)),&#xd;&#xa;with_variable('TopMargin',if(@PhotoView_TopMargin is null, to_real(8)*@map_scale/1000,to_real(@PhotoView_TopMargin)*@map_scale/1000),&#xd;&#xa;with_variable('PhotoBySideMargin',if(@PhotoView_PhotoBySideMargin is null, to_real(15),to_real(@PhotoView_PhotoBySideMargin)),&#xd;&#xa;with_variable('SideMargin',&#x9;@map_extent_width /(1+(@PhotoBySideMargin+1)*@Number),&#xd;&#xa;with_variable('i',   array_find(&#xd;&#xa;                    array_foreach(&#xd;&#xa;                    array_sort(&#xd;&#xa;                    array_slice(&#xd;&#xa;                    array_agg(  array( $x, $id) ,order_by:=distance( @map_extent_center , $geometry ),filter:=if( attribute(  'invisible' ),false,true))&#xd;&#xa;                    ,0,@Number-1)&#xd;&#xa;                    ),@element[1])&#xd;&#xa;                    ,$id),&#xd;&#xa;with_variable('p0',&#xd;&#xa;&#x9;translate(@map_extent_center,(1+@PhotoBySideMargin/2)*@SideMargin-@map_extent_width/2,&#xd;&#xa;&#x9;&#x9;@map_extent_height/2-@TopMargin),&#xd;&#xa;translate(@p0,(1+@PhotoBySideMargin)*@SideMargin*@i,0)&#xd;&#xa;))))))&#xd;&#xa;"/>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" name="name" type="QString"/>
              <Option name="properties"/>
              <Option value="collection" name="type" type="QString"/>
            </Option>
          </data_defined_properties>
          <symbol clip_to_extent="1" alpha="1" name="@0@3" force_rhr="0" type="marker">
            <layer class="RasterMarker" enabled="1" locked="0" pass="0">
              <prop k="alpha" v="1"/>
              <prop k="angle" v="0"/>
              <prop k="fixedAspectRatio" v="0"/>
              <prop k="horizontal_anchor_point" v="1"/>
              <prop k="imageFile" v=""/>
              <prop k="offset" v="0,0"/>
              <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="offset_unit" v="MM"/>
              <prop k="scale_method" v="diameter"/>
              <prop k="size" v="2"/>
              <prop k="size_map_unit_scale" v="3x:0,0,0,0,0,0"/>
              <prop k="size_unit" v="MapUnit"/>
              <prop k="vertical_anchor_point" v="0"/>
              <effect enabled="1" type="effectStack">
                <effect type="dropShadow">
                  <prop k="blend_mode" v="13"/>
                  <prop k="blur_level" v="2.645"/>
                  <prop k="blur_unit" v="MM"/>
                  <prop k="blur_unit_scale" v="3x:0,0,0,0,0,0"/>
                  <prop k="color" v="0,0,0,255"/>
                  <prop k="draw_mode" v="2"/>
                  <prop k="enabled" v="0"/>
                  <prop k="offset_angle" v="135"/>
                  <prop k="offset_distance" v="2"/>
                  <prop k="offset_unit" v="MM"/>
                  <prop k="offset_unit_scale" v="3x:0,0,0,0,0,0"/>
                  <prop k="opacity" v="1"/>
                </effect>
                <effect type="outerGlow">
                  <prop k="blend_mode" v="0"/>
                  <prop k="blur_level" v="0.5"/>
                  <prop k="blur_unit" v="MM"/>
                  <prop k="blur_unit_scale" v="3x:0,0,0,0,0,0"/>
                  <prop k="color1" v="0,0,255,255"/>
                  <prop k="color2" v="0,255,0,255"/>
                  <prop k="color_type" v="0"/>
                  <prop k="discrete" v="0"/>
                  <prop k="draw_mode" v="2"/>
                  <prop k="enabled" v="1"/>
                  <prop k="opacity" v="0.5"/>
                  <prop k="rampType" v="gradient"/>
                  <prop k="single_color" v="255,255,255,255"/>
                  <prop k="spread" v="1"/>
                  <prop k="spread_unit" v="MM"/>
                  <prop k="spread_unit_scale" v="3x:0,0,0,0,0,0"/>
                </effect>
                <effect type="drawSource">
                  <prop k="blend_mode" v="0"/>
                  <prop k="draw_mode" v="2"/>
                  <prop k="enabled" v="1"/>
                  <prop k="opacity" v="1"/>
                </effect>
                <effect type="innerShadow">
                  <prop k="blend_mode" v="13"/>
                  <prop k="blur_level" v="2.645"/>
                  <prop k="blur_unit" v="MM"/>
                  <prop k="blur_unit_scale" v="3x:0,0,0,0,0,0"/>
                  <prop k="color" v="0,0,0,255"/>
                  <prop k="draw_mode" v="2"/>
                  <prop k="enabled" v="0"/>
                  <prop k="offset_angle" v="135"/>
                  <prop k="offset_distance" v="2"/>
                  <prop k="offset_unit" v="MM"/>
                  <prop k="offset_unit_scale" v="3x:0,0,0,0,0,0"/>
                  <prop k="opacity" v="1"/>
                </effect>
                <effect type="innerGlow">
                  <prop k="blend_mode" v="0"/>
                  <prop k="blur_level" v="2.645"/>
                  <prop k="blur_unit" v="MM"/>
                  <prop k="blur_unit_scale" v="3x:0,0,0,0,0,0"/>
                  <prop k="color1" v="0,0,255,255"/>
                  <prop k="color2" v="0,255,0,255"/>
                  <prop k="color_type" v="0"/>
                  <prop k="discrete" v="0"/>
                  <prop k="draw_mode" v="2"/>
                  <prop k="enabled" v="0"/>
                  <prop k="opacity" v="0.5"/>
                  <prop k="rampType" v="gradient"/>
                  <prop k="single_color" v="255,255,255,255"/>
                  <prop k="spread" v="2"/>
                  <prop k="spread_unit" v="MM"/>
                  <prop k="spread_unit_scale" v="3x:0,0,0,0,0,0"/>
                </effect>
              </effect>
              <data_defined_properties>
                <Option type="Map">
                  <Option value="" name="name" type="QString"/>
                  <Option name="properties" type="Map">
                    <Option name="name" type="Map">
                      <Option value="true" name="active" type="bool"/>
                      <Option value="photo" name="field" type="QString"/>
                      <Option value="2" name="type" type="int"/>
                    </Option>
                    <Option name="width" type="Map">
                      <Option value="true" name="active" type="bool"/>
                      <Option value="with_variable('Number',if(@PhotoView_Number is null, to_int(5),to_int(@PhotoView_Number)),&#xd;&#xa;with_variable('TopMargin',if(@PhotoView_TopMargin is null, to_real(8)*@map_scale/1000,to_real(@PhotoView_TopMargin)*@map_scale/1000),&#xd;&#xa;with_variable('PhotoBySideMargin',if(@PhotoView_PhotoBySideMargin is null, to_real(15),to_real(@PhotoView_PhotoBySideMargin)),&#xd;&#xa;with_variable('Leader',if(@PhotoView_Leader is null, to_real(0.6),to_real(@PhotoView_Leader)),&#xd;&#xa;with_variable('SideMargin',&#xd;&#xa;&#x9;@map_extent_width /(1+(@PhotoBySideMargin+1)*@Number),&#xd;&#xa;&#x9;@PhotoBySideMargin*@SideMargin)&#xd;&#xa;))))" name="expression" type="QString"/>
                      <Option value="3" name="type" type="int"/>
                    </Option>
                  </Option>
                  <Option value="collection" name="type" type="QString"/>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol clip_to_extent="1" alpha="0.6" name="1" force_rhr="0" type="marker">
        <layer class="SimpleMarker" enabled="1" locked="0" pass="2">
          <prop k="angle" v="0"/>
          <prop k="color" v="255,255,255,255"/>
          <prop k="horizontal_anchor_point" v="1"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="name" v="quarter_circle"/>
          <prop k="offset" v="0,0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="outline_color" v="35,35,35,255"/>
          <prop k="outline_style" v="solid"/>
          <prop k="outline_width" v="0"/>
          <prop k="outline_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="scale_method" v="diameter"/>
          <prop k="size" v="5"/>
          <prop k="size_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="size_unit" v="MM"/>
          <prop k="vertical_anchor_point" v="1"/>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" name="name" type="QString"/>
              <Option name="properties" type="Map">
                <Option name="angle" type="Map">
                  <Option value="true" name="active" type="bool"/>
                  <Option value="&quot;direction&quot; + 45" name="expression" type="QString"/>
                  <Option value="3" name="type" type="int"/>
                </Option>
              </Option>
              <Option value="collection" name="type" type="QString"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer class="SimpleMarker" enabled="1" locked="0" pass="3">
          <prop k="angle" v="0"/>
          <prop k="color" v="0,0,0,255"/>
          <prop k="horizontal_anchor_point" v="1"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="name" v="circle"/>
          <prop k="offset" v="0,0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="outline_color" v="35,35,35,255"/>
          <prop k="outline_style" v="no"/>
          <prop k="outline_width" v="0"/>
          <prop k="outline_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="scale_method" v="diameter"/>
          <prop k="size" v="0.75"/>
          <prop k="size_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="size_unit" v="MM"/>
          <prop k="vertical_anchor_point" v="1"/>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" name="name" type="QString"/>
              <Option name="properties" type="Map">
                <Option name="angle" type="Map">
                  <Option value="false" name="active" type="bool"/>
                  <Option value="1" name="type" type="int"/>
                  <Option value="" name="val" type="QString"/>
                </Option>
              </Option>
              <Option value="collection" name="type" type="QString"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol clip_to_extent="1" alpha="0.6" name="2" force_rhr="0" type="marker">
        <layer class="SimpleMarker" enabled="1" locked="0" pass="0">
          <prop k="angle" v="0"/>
          <prop k="color" v="179,179,179,255"/>
          <prop k="horizontal_anchor_point" v="1"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="name" v="quarter_circle"/>
          <prop k="offset" v="0,0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="outline_color" v="35,35,35,255"/>
          <prop k="outline_style" v="solid"/>
          <prop k="outline_width" v="0"/>
          <prop k="outline_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="scale_method" v="diameter"/>
          <prop k="size" v="5"/>
          <prop k="size_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="size_unit" v="MM"/>
          <prop k="vertical_anchor_point" v="1"/>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" name="name" type="QString"/>
              <Option name="properties" type="Map">
                <Option name="angle" type="Map">
                  <Option value="true" name="active" type="bool"/>
                  <Option value="&quot;direction&quot; + 45" name="expression" type="QString"/>
                  <Option value="3" name="type" type="int"/>
                </Option>
              </Option>
              <Option value="collection" name="type" type="QString"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer class="SimpleMarker" enabled="1" locked="0" pass="1">
          <prop k="angle" v="0"/>
          <prop k="color" v="0,0,0,255"/>
          <prop k="horizontal_anchor_point" v="1"/>
          <prop k="joinstyle" v="bevel"/>
          <prop k="name" v="circle"/>
          <prop k="offset" v="0,0"/>
          <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="offset_unit" v="MM"/>
          <prop k="outline_color" v="35,35,35,255"/>
          <prop k="outline_style" v="no"/>
          <prop k="outline_width" v="0"/>
          <prop k="outline_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="outline_width_unit" v="MM"/>
          <prop k="scale_method" v="diameter"/>
          <prop k="size" v="0.75"/>
          <prop k="size_map_unit_scale" v="3x:0,0,0,0,0,0"/>
          <prop k="size_unit" v="MM"/>
          <prop k="vertical_anchor_point" v="1"/>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" name="name" type="QString"/>
              <Option name="properties" type="Map">
                <Option name="angle" type="Map">
                  <Option value="false" name="active" type="bool"/>
                  <Option value="1" name="type" type="int"/>
                  <Option value="" name="val" type="QString"/>
                </Option>
              </Option>
              <Option value="collection" name="type" type="QString"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </symbols>
  </renderer-v2>
  <labeling type="rule-based">
    <rules key="{452786f7-e535-4d7b-8845-243e58f5e4a3}">
      <rule key="{dd9ea2c6-81f1-4f4a-a3cb-43a4c95ecbd8}" filter="/*&#xd;&#xa;写真表示地物かの条件判定　シンボロジ、ラベル共通&#xd;&#xa;*/&#xd;&#xa;CASE &#xd;&#xa;WHEN  @map_rotation &lt;> 0 THEN false&#xd;&#xa;WHEN  attribute(  'invisible' ) THEN false&#xd;&#xa;ELSE&#xd;&#xa;with_variable('Number',if(@PhotoView_Number is null, to_int(5),to_int(@PhotoView_Number)),&#xd;&#xa;with_variable('DistRank',   array_find(&#xd;&#xa;&#x9; array_foreach( &#xd;&#xa;&#x9;array_sort( &#xd;&#xa;&#x9;&#x9;array_agg(  array(  distance( @map_extent_center , $geometry ),$id  ) ,filter:=if( attribute(  'invisible' ),false,true))&#xd;&#xa;&#x9;),&#xd;&#xa;&#x9;@element[1])&#xd;&#xa;&#x9;,$id),&#xd;&#xa;@DistRank&lt;@Number)&#xd;&#xa;)&#xd;&#xa;END" description="PhotoViewLabel">
        <settings calloutType="simple">
          <text-style useSubstitutions="0" textOrientation="horizontal" fieldName="filename" fontWeight="50" fontStrikeout="0" fontLetterSpacing="0" allowHtml="0" fontUnderline="0" namedStyle="Regular" fontSizeMapUnitScale="3x:0,0,0,0,0,0" previewBkgrdColor="255,255,255,255" fontFamily="Arial" isExpression="0" textColor="0,0,0,255" fontSizeUnit="MapUnit" fontWordSpacing="0" fontItalic="0" capitalization="0" fontSize="10" fontKerning="1" blendMode="0" textOpacity="1" multilineHeight="1">
            <text-buffer bufferOpacity="1" bufferNoFill="1" bufferColor="250,250,250,255" bufferSize="0.6" bufferBlendMode="0" bufferJoinStyle="128" bufferDraw="1" bufferSizeMapUnitScale="3x:0,0,0,0,0,0" bufferSizeUnits="MM"/>
            <text-mask maskType="0" maskSizeUnits="MM" maskedSymbolLayers="" maskEnabled="0" maskSize="0" maskJoinStyle="128" maskOpacity="1" maskSizeMapUnitScale="3x:0,0,0,0,0,0"/>
            <background shapeOffsetY="0" shapeSizeUnit="Point" shapeRadiiMapUnitScale="3x:0,0,0,0,0,0" shapeSizeY="0" shapeBorderColor="128,128,128,255" shapeType="0" shapeOpacity="1" shapeRadiiY="0" shapeJoinStyle="64" shapeRotationType="0" shapeRadiiX="0" shapeFillColor="255,255,255,255" shapeSizeType="0" shapeOffsetX="0" shapeBlendMode="0" shapeDraw="0" shapeSizeX="0" shapeOffsetUnit="Point" shapeBorderWidthUnit="Point" shapeSizeMapUnitScale="3x:0,0,0,0,0,0" shapeBorderWidthMapUnitScale="3x:0,0,0,0,0,0" shapeSVGFile="" shapeOffsetMapUnitScale="3x:0,0,0,0,0,0" shapeRotation="0" shapeRadiiUnit="Point" shapeBorderWidth="0">
              <symbol clip_to_extent="1" alpha="1" name="markerSymbol" force_rhr="0" type="marker">
                <layer class="SimpleMarker" enabled="1" locked="0" pass="0">
                  <prop k="angle" v="0"/>
                  <prop k="color" v="243,166,178,255"/>
                  <prop k="horizontal_anchor_point" v="1"/>
                  <prop k="joinstyle" v="bevel"/>
                  <prop k="name" v="circle"/>
                  <prop k="offset" v="0,0"/>
                  <prop k="offset_map_unit_scale" v="3x:0,0,0,0,0,0"/>
                  <prop k="offset_unit" v="MM"/>
                  <prop k="outline_color" v="35,35,35,255"/>
                  <prop k="outline_style" v="solid"/>
                  <prop k="outline_width" v="0"/>
                  <prop k="outline_width_map_unit_scale" v="3x:0,0,0,0,0,0"/>
                  <prop k="outline_width_unit" v="MM"/>
                  <prop k="scale_method" v="diameter"/>
                  <prop k="size" v="2"/>
                  <prop k="size_map_unit_scale" v="3x:0,0,0,0,0,0"/>
                  <prop k="size_unit" v="MM"/>
                  <prop k="vertical_anchor_point" v="1"/>
                  <data_defined_properties>
                    <Option type="Map">
                      <Option value="" name="name" type="QString"/>
                      <Option name="properties"/>
                      <Option value="collection" name="type" type="QString"/>
                    </Option>
                  </data_defined_properties>
                </layer>
              </symbol>
            </background>
            <shadow shadowOpacity="0.7" shadowColor="0,0,0,255" shadowScale="100" shadowDraw="0" shadowRadiusAlphaOnly="0" shadowOffsetUnit="MM" shadowOffsetMapUnitScale="3x:0,0,0,0,0,0" shadowOffsetDist="1" shadowRadiusMapUnitScale="3x:0,0,0,0,0,0" shadowUnder="0" shadowBlendMode="6" shadowOffsetGlobal="1" shadowRadiusUnit="MM" shadowOffsetAngle="135" shadowRadius="1.5"/>
            <dd_properties>
              <Option type="Map">
                <Option value="" name="name" type="QString"/>
                <Option name="properties"/>
                <Option value="collection" name="type" type="QString"/>
              </Option>
            </dd_properties>
            <substitutions/>
          </text-style>
          <text-format multilineAlign="3" addDirectionSymbol="0" plussign="0" wrapChar="" reverseDirectionSymbol="0" useMaxLineLengthForAutoWrap="1" autoWrapLength="0" decimals="3" leftDirectionSymbol="&lt;" rightDirectionSymbol=">" placeDirectionSymbol="0" formatNumbers="0"/>
          <placement yOffset="0" placementFlags="10" repeatDistanceMapUnitScale="3x:0,0,0,0,0,0" xOffset="0" predefinedPositionOrder="TR,TL,BR,BL,R,L,TSR,BSR" maxCurvedCharAngleIn="25" geometryGeneratorType="PointGeometry" offsetType="1" layerType="PointGeometry" repeatDistanceUnits="MM" geometryGenerator="/*&#xd;&#xa;ラスタ画像マーカーのアンカー位置、ラベルのアンカー位置　共通&#xd;&#xa;*/&#xd;&#xa;with_variable('Number',if(@PhotoView_Number is null, to_int(5),to_int(@PhotoView_Number)),&#xd;&#xa;with_variable('TopMargin',if(@PhotoView_TopMargin is null, to_real(8)*@map_scale/1000,to_real(@PhotoView_TopMargin)*@map_scale/1000),&#xd;&#xa;with_variable('PhotoBySideMargin',if(@PhotoView_PhotoBySideMargin is null, to_real(15),to_real(@PhotoView_PhotoBySideMargin)),&#xd;&#xa;with_variable('SideMargin',&#x9;@map_extent_width /(1+(@PhotoBySideMargin+1)*@Number),&#xd;&#xa;with_variable('i',   array_find(&#xd;&#xa;                    array_foreach(&#xd;&#xa;                    array_sort(&#xd;&#xa;                    array_slice(&#xd;&#xa;                    array_agg(  array( $x, $id) ,order_by:=distance( @map_extent_center , $geometry ),filter:=if( attribute(  'invisible' ),false,true))&#xd;&#xa;                    ,0,@Number-1)&#xd;&#xa;                    ),@element[1])&#xd;&#xa;                    ,$id),&#xd;&#xa;with_variable('p0',&#xd;&#xa;&#x9;translate(@map_extent_center,(1+@PhotoBySideMargin/2)*@SideMargin-@map_extent_width/2,&#xd;&#xa;&#x9;&#x9;@map_extent_height/2-@TopMargin),&#xd;&#xa;translate(@p0,(1+@PhotoBySideMargin)*@SideMargin*@i,0)&#xd;&#xa;))))))&#xd;&#xa;" lineAnchorPercent="0.5" priority="5" offsetUnits="MM" dist="0" preserveRotation="1" distMapUnitScale="3x:0,0,0,0,0,0" repeatDistance="0" placement="1" maxCurvedCharAngleOut="-25" overrunDistance="0" geometryGeneratorEnabled="1" polygonPlacementFlags="2" centroidWhole="0" rotationAngle="0" centroidInside="0" overrunDistanceUnit="MM" labelOffsetMapUnitScale="3x:0,0,0,0,0,0" fitInPolygonOnly="0" quadOffset="1" overrunDistanceMapUnitScale="3x:0,0,0,0,0,0" lineAnchorType="0" distUnits="MM"/>
          <rendering obstacleFactor="1" scaleVisibility="0" maxNumLabels="2000" obstacleType="1" minFeatureSize="0" scaleMin="0" zIndex="0" drawLabels="1" scaleMax="0" fontMinPixelSize="3" fontLimitPixelSize="0" fontMaxPixelSize="10000" displayAll="0" obstacle="1" upsidedownLabels="0" labelPerPart="0" mergeLines="0" limitNumLabels="0"/>
          <dd_properties>
            <Option type="Map">
              <Option value="" name="name" type="QString"/>
              <Option name="properties" type="Map">
                <Option name="Size" type="Map">
                  <Option value="true" name="active" type="bool"/>
                  <Option value="with_variable('SingleByteCaracterWidth',if(@PhotoView_SingleByteCaracterWidth is null, to_real(0.8),to_real(@PhotoView_SingleByteCaracterWidth)),&#xd;&#xa;with_variable('Number',if(@PhotoView_Number is null, to_int(5),to_int(@PhotoView_Number)),&#xd;&#xa;with_variable('PhotoBySideMargin',if(@PhotoView_PhotoBySideMargin is null, to_real(15),to_real(@PhotoView_PhotoBySideMargin)),&#xd;&#xa;-- with_variable('LabelSize',if(@PhotoView_LabelSize is null, to_real(6)*@map_scale/1000,to_real(@PhotoView_LabelSize)*@map_scale/1000),&#xd;&#xa;with_variable('LabelSize',if(@PhotoView_TopMargin is null, to_real(7)*@map_scale/1000,(to_real(@PhotoView_TopMargin)-1)*@map_scale/1000),&#xd;&#xa;with_variable('SideMargin',&#xd;&#xa;    @map_extent_width /(1+(@PhotoBySideMargin+1)*@Number),&#xd;&#xa;with_variable('PhotoWidth',@PhotoBySideMargin*@SideMargin,&#xd;&#xa;with_variable('StrLen',&#xd;&#xa;    eval( array_to_string(&#xd;&#xa;    array_foreach(&#xd;&#xa;        array_remove_all( string_to_array( &quot;filename&quot; ,''),''),&#xd;&#xa;    if(@element ~ '[ -~]',@SingleByteCaracterWidth,1))&#xd;&#xa;,'+'))&#xd;&#xa;,&#xd;&#xa;if(@PhotoWidth>@LabelSize*@StrLen,&#xd;&#xa;    @LabelSize,@PhotoWidth/@StrLen)&#xd;&#xa;)))))))" name="expression" type="QString"/>
                  <Option value="3" name="type" type="int"/>
                </Option>
              </Option>
              <Option value="collection" name="type" type="QString"/>
            </Option>
          </dd_properties>
          <callout type="simple">
            <Option type="Map">
              <Option value="pole_of_inaccessibility" name="anchorPoint" type="QString"/>
              <Option name="ddProperties" type="Map">
                <Option value="" name="name" type="QString"/>
                <Option name="properties"/>
                <Option value="collection" name="type" type="QString"/>
              </Option>
              <Option value="false" name="drawToAllParts" type="bool"/>
              <Option value="0" name="enabled" type="QString"/>
              <Option value="point_on_exterior" name="labelAnchorPoint" type="QString"/>
              <Option value="&lt;symbol clip_to_extent=&quot;1&quot; alpha=&quot;1&quot; name=&quot;symbol&quot; force_rhr=&quot;0&quot; type=&quot;line&quot;>&lt;layer class=&quot;SimpleLine&quot; enabled=&quot;1&quot; locked=&quot;0&quot; pass=&quot;0&quot;>&lt;prop k=&quot;align_dash_pattern&quot; v=&quot;0&quot;/>&lt;prop k=&quot;capstyle&quot; v=&quot;square&quot;/>&lt;prop k=&quot;customdash&quot; v=&quot;5;2&quot;/>&lt;prop k=&quot;customdash_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;prop k=&quot;customdash_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;dash_pattern_offset&quot; v=&quot;0&quot;/>&lt;prop k=&quot;dash_pattern_offset_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;prop k=&quot;dash_pattern_offset_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;draw_inside_polygon&quot; v=&quot;0&quot;/>&lt;prop k=&quot;joinstyle&quot; v=&quot;bevel&quot;/>&lt;prop k=&quot;line_color&quot; v=&quot;60,60,60,255&quot;/>&lt;prop k=&quot;line_style&quot; v=&quot;solid&quot;/>&lt;prop k=&quot;line_width&quot; v=&quot;0.3&quot;/>&lt;prop k=&quot;line_width_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;offset&quot; v=&quot;0&quot;/>&lt;prop k=&quot;offset_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;prop k=&quot;offset_unit&quot; v=&quot;MM&quot;/>&lt;prop k=&quot;ring_filter&quot; v=&quot;0&quot;/>&lt;prop k=&quot;tweak_dash_pattern_on_corners&quot; v=&quot;0&quot;/>&lt;prop k=&quot;use_custom_dash&quot; v=&quot;0&quot;/>&lt;prop k=&quot;width_map_unit_scale&quot; v=&quot;3x:0,0,0,0,0,0&quot;/>&lt;data_defined_properties>&lt;Option type=&quot;Map&quot;>&lt;Option value=&quot;&quot; name=&quot;name&quot; type=&quot;QString&quot;/>&lt;Option name=&quot;properties&quot;/>&lt;Option value=&quot;collection&quot; name=&quot;type&quot; type=&quot;QString&quot;/>&lt;/Option>&lt;/data_defined_properties>&lt;/layer>&lt;/symbol>" name="lineSymbol" type="QString"/>
              <Option value="0" name="minLength" type="double"/>
              <Option value="3x:0,0,0,0,0,0" name="minLengthMapUnitScale" type="QString"/>
              <Option value="MM" name="minLengthUnit" type="QString"/>
              <Option value="0" name="offsetFromAnchor" type="double"/>
              <Option value="3x:0,0,0,0,0,0" name="offsetFromAnchorMapUnitScale" type="QString"/>
              <Option value="MM" name="offsetFromAnchorUnit" type="QString"/>
              <Option value="0" name="offsetFromLabel" type="double"/>
              <Option value="3x:0,0,0,0,0,0" name="offsetFromLabelMapUnitScale" type="QString"/>
              <Option value="MM" name="offsetFromLabelUnit" type="QString"/>
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
    <actionsetting icon="" id="{b191087f-0fdf-4b1e-b8c1-e8b658df9384}" isEnabledOnlyWhenEditable="0" name="open" capture="0" type="5" shortTitle="" action="[%photo%]" notificationMessage="">
      <actionScope id="Canvas"/>
      <actionScope id="Field"/>
      <actionScope id="Feature"/>
      <actionScope id="Layer"/>
    </actionsetting>
  </attributeactions>
  <layerGeometryType>0</layerGeometryType>
</qgis>
