<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis labelsEnabled="1" version="3.28.2-Firenze" readOnly="0" styleCategories="LayerConfiguration|Symbology|Labeling|Fields|Forms|Actions|AttributeTable">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <renderer-v2 enableorderby="0" referencescale="-1" forceraster="0" type="RuleRenderer" symbollevels="0">
    <rules key="{4c83798d-3edf-4754-852c-330910c581ec}">
      <rule filter="/*&#xd;&#xa;写真表示地物かの条件判定　シンボロジ、ラベル共通&#xd;&#xa;*/&#xd;&#xa;with_variable('para',map(&#xd;&#xa; 'Number',  to_int( coalesce(@PhotoView_Number , 8) *if( @qgis_platform&lt;>'mobile',1,if( @map_extent_width > @map_extent_height ,1, @map_extent_width / @map_extent_height ))) ,&#xd;&#xa; 'TopMargin', to_real(coalesce(@PhotoView_TopMargin ,6.0)+if( @qgis_platform='mobile',3,0))*@map_scale/1000,&#xd;&#xa; 'SideMargin', if( @qgis_platform='mobile',9,1) * @map_scale / 1000,&#xd;&#xa; 'PhotoByGap', 15.0),&#xd;&#xa;with_variable('Gap',(@map_extent_width - @para['SideMargin']*2) /((@para['PhotoByGap']+1)*@para['Number']-1),&#xd;&#xa;with_variable('Extent',&#xd;&#xa;&#x9; intersection(  @map_extent , translate(  @map_extent ,0,-@para['PhotoByGap']*@Gap*0.800-@para['TopMargin'])),&#xd;&#xa;CASE &#xd;&#xa;WHEN  @map_rotation &lt;> 0 THEN false&#xd;&#xa;WHEN  attribute(  'invisible' ) THEN false&#xd;&#xa;WHEN  not within(   $geometry , @Extent )  THEN false&#xd;&#xa;ELSE&#xd;&#xa;with_variable('DistRank', array_find(&#xd;&#xa;&#x9; array_foreach(&#xd;&#xa;&#x9;array_sort( &#xd;&#xa;&#x9;&#x9;array_agg(  array(  distance(  @map_extent_center , $geometry ),$id  ) ,filter:=if( attribute(  'invisible' ),false,true) and within(   $geometry , @Extent ))&#xd;&#xa;&#x9;),&#xd;&#xa;&#x9;@element[1])&#xd;&#xa;&#x9;,$id),&#xd;&#xa;@DistRank&lt;@para['Number'])&#xd;&#xa;END&#xd;&#xa;)))&#xd;&#xa;&#xd;&#xa;" symbol="0" label="PHOTO" key="{580b1a51-0fff-4616-b191-d07f43f2f41a}"/>
      <rule filter="ELSE" symbol="1" label="far" key="{11dde42b-66f3-4248-b456-51b3af11524f}"/>
      <rule filter="/*&#xd;&#xa;invisible フィールドがtrueの場合は写真表示から除外、アイコンはグレー&#xd;&#xa;*/&#xd;&#xa;  attribute( 'invisible' )&#xd;&#xa;&#xd;&#xa;/*&#xd;&#xa;photoview履歴・メモ,motohirooya&#xd;&#xa;2022/2/23　動くものができる&#xd;&#xa;2022/3/2&#xd;&#xa;・引き出し線を曲線（smooth）、引き出し線の起点をラスタ画像マーカと同じに。このため、@LEADER変数が不要に&#xd;&#xa;・invisibleフィールド（真偽値）を導入、値がtrueの場合は写真を非表示、それ以外（false,nll,フィールドが無い場合）は写真を表示）&#xd;&#xa;・photoview_inportモデル作成。invisibleフィールドの追加は属性リファクタリング（フィールド演算、フィールド追加では、真偽値が選べない。バージョンアップで「ジオタグ（位置情報）付きの写真」の出力がかわることに注意）&#xd;&#xa;・撮影位置を矢印から扇に変更&#xd;&#xa;2022/3/13 色の調整、コメントの記載&#xd;&#xa;2022/9/14 ラベルが衝突して表示されないことがあったので、プロジェクト変数に全角文字に対する半角文字の幅のパラメータを追加し、ラベルサイズの計算を行うよう変更（以前は0.66・・・の固定値を使用していた）&#xd;&#xa;ラベルサイズのプロジェクト変数を削除し、写真の上の余白-1mmを最大ラベルサイズとした。&#xd;&#xa;表示範囲外の地物は写真を表示しない条件を追加&#xd;&#xa;2022/9/19 写真と引き出し線が重ならないよう、写真を表示する上部はフィルタ範囲から除外（写真の縦横比は0.800を仮定）&#xd;&#xa;2022/9/23 label フィールド追加、値がある場合はラベルのフィールドとして使用&#xd;&#xa;2022/9/30 PhotoView_SingleByteCaracterWidth の既定値を0.8→0.7&#xd;&#xa;中心点との距離が同一の場合、順序がおかしくなる可能性があったのを修正&#xd;&#xa;labelフィールドがない場合、文字サイズの計算がおかしかったのを修正&#xd;&#xa;2022/10/24 プロジェクト変数未設定時の文字サイズ修正、方位角nullの場合は●を表示、写真選択基準の距離の起点を画面中心から対象範囲（@Extent）に&#xd;&#xa;2022/11/8&#xd;&#xa;シンボルとラベルの色を変数PhotoView_Colorに設定。Qfield用の色々調整。photoフィールドがない場合はrelpathフィールドを参照するように&#xd;&#xa;2022/11/17 with_variableをマップ型オブジェクトでまとめた。写真選択基準の距離の起点を画面中心に戻した。&#xd;&#xa;2023/1/16 &quot;photo&quot;の写真がない場合、 @project_folder  ||'/'||  &quot;relpath&quot;を使用する。 &#xd;&#xa;既知の問題&#xd;&#xa;・QGIS3.16では縦撮りの写真が横になる。QGIS3.22では縦になるがアンカー位置が写真の中間部になる（期待されるのは写真上部中央）&#xd;&#xa;・地図の回転には対応しない&#xd;&#xa;*/" symbol="2" label="invisible" key="{3881f3a2-408f-4e64-84f6-d42475562fae}"/>
    </rules>
    <symbols>
      <symbol alpha="0.6" frame_rate="10" clip_to_extent="1" force_rhr="0" is_animated="0" name="0" type="marker">
        <data_defined_properties>
          <Option type="Map">
            <Option name="name" type="QString" value=""/>
            <Option name="properties"/>
            <Option name="type" type="QString" value="collection"/>
          </Option>
        </data_defined_properties>
        <layer pass="6" enabled="1" locked="0" class="GeometryGenerator">
          <Option type="Map">
            <Option name="SymbolType" type="QString" value="Line"/>
            <Option name="geometryModifier" type="QString" value="/*&#xd;&#xa;写真と撮影位置を結ぶライン 写真のアンカー位置を@piとし、一旦下に下げてから撮影位置と結ぶ&#xd;&#xa;*/&#xd;&#xa;&#xd;&#xa;with_variable('para',map(&#xd;&#xa; 'Number',  to_int( coalesce(@PhotoView_Number , 8) *if( @qgis_platform&lt;>'mobile',1,if( @map_extent_width > @map_extent_height ,1, @map_extent_width / @map_extent_height ))) ,&#xd;&#xa; 'TopMargin', to_real(coalesce(@PhotoView_TopMargin ,6.0)+if( @qgis_platform='mobile',3,0))*@map_scale/1000,&#xd;&#xa; 'SideMargin', if( @qgis_platform='mobile',9,1) * @map_scale / 1000,&#xd;&#xa; 'PhotoByGap', 15.0),&#xd;&#xa;with_variable('Gap',(@map_extent_width - @para['SideMargin']*2) /((@para['PhotoByGap']+1)*@para['Number']-1),&#xd;&#xa;with_variable('Extent',intersection(  @map_extent , translate(  @map_extent ,0,-@para['PhotoByGap']*@Gap*0.800-@para['TopMargin'])),&#xd;&#xa;with_variable('i',  --左から何番目か&#xd;&#xa; array_find(&#xd;&#xa;  array_foreach(&#xd;&#xa;    array_sort(&#xd;&#xa;&#x9; array_foreach( &#xd;&#xa;  &#x9;  array_slice(&#xd;&#xa;       array_sort( &#xd;&#xa;        array_agg(  array(  distance(  @map_extent_center , $geometry ),$id ,$x ) ,filter:=if( attribute(  'invisible' ),false,true) and within(   $geometry , @Extent ))&#xd;&#xa;        )&#xd;&#xa;      ,0,@para['Number']-1)&#xd;&#xa;&#x9;, array_reverse(@element))&#xd;&#xa;    )&#xd;&#xa;  ,@element[1])&#xd;&#xa; ,$id),&#x9;&#x9;-- i の定義終わり&#xd;&#xa; with_variable('p0',translate(@map_extent_center,@para['SideMargin']+(@para['PhotoByGap']/2)*@Gap-@map_extent_width/2,&#xd;&#xa;  @map_extent_height/2-@para['TopMargin']),&#xd;&#xa;with_variable('pi',&#xd;&#xa;&#x9;translate(@p0,(1+@para['PhotoByGap'])*@Gap*@i,0),&#xd;&#xa;  smooth( make_line( @pi, make_point(x(@pi), (y(@pi)+y($geometry))/2 ) , $geometry  ) ,5 ) &#xd;&#xa;))))))&#xd;&#xa;"/>
            <Option name="units" type="QString" value="MapUnit"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties"/>
              <Option name="type" type="QString" value="collection"/>
            </Option>
          </data_defined_properties>
          <symbol alpha="1" frame_rate="10" clip_to_extent="1" force_rhr="0" is_animated="0" name="@0@0" type="line">
            <data_defined_properties>
              <Option type="Map">
                <Option name="name" type="QString" value=""/>
                <Option name="properties"/>
                <Option name="type" type="QString" value="collection"/>
              </Option>
            </data_defined_properties>
            <layer pass="0" enabled="1" locked="0" class="SimpleLine">
              <Option type="Map">
                <Option name="align_dash_pattern" type="QString" value="0"/>
                <Option name="capstyle" type="QString" value="square"/>
                <Option name="customdash" type="QString" value="5;2"/>
                <Option name="customdash_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
                <Option name="customdash_unit" type="QString" value="MM"/>
                <Option name="dash_pattern_offset" type="QString" value="0"/>
                <Option name="dash_pattern_offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
                <Option name="dash_pattern_offset_unit" type="QString" value="MM"/>
                <Option name="draw_inside_polygon" type="QString" value="0"/>
                <Option name="joinstyle" type="QString" value="bevel"/>
                <Option name="line_color" type="QString" value="15,245,245,255"/>
                <Option name="line_style" type="QString" value="solid"/>
                <Option name="line_width" type="QString" value="0.2"/>
                <Option name="line_width_unit" type="QString" value="MM"/>
                <Option name="offset" type="QString" value="0"/>
                <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
                <Option name="offset_unit" type="QString" value="MM"/>
                <Option name="ring_filter" type="QString" value="0"/>
                <Option name="trim_distance_end" type="QString" value="0"/>
                <Option name="trim_distance_end_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
                <Option name="trim_distance_end_unit" type="QString" value="MM"/>
                <Option name="trim_distance_start" type="QString" value="0"/>
                <Option name="trim_distance_start_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
                <Option name="trim_distance_start_unit" type="QString" value="MM"/>
                <Option name="tweak_dash_pattern_on_corners" type="QString" value="0"/>
                <Option name="use_custom_dash" type="QString" value="0"/>
                <Option name="width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
              </Option>
              <data_defined_properties>
                <Option type="Map">
                  <Option name="name" type="QString" value=""/>
                  <Option name="properties" type="Map">
                    <Option name="outlineColor" type="Map">
                      <Option name="active" type="bool" value="true"/>
                      <Option name="expression" type="QString" value="@PhotoView_Color"/>
                      <Option name="type" type="int" value="3"/>
                    </Option>
                  </Option>
                  <Option name="type" type="QString" value="collection"/>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </layer>
        <layer pass="4" enabled="1" locked="0" class="SimpleMarker">
          <Option type="Map">
            <Option name="angle" type="QString" value="0"/>
            <Option name="cap_style" type="QString" value="square"/>
            <Option name="color" type="QString" value="15,245,245,255"/>
            <Option name="horizontal_anchor_point" type="QString" value="1"/>
            <Option name="joinstyle" type="QString" value="bevel"/>
            <Option name="name" type="QString" value="quarter_circle"/>
            <Option name="offset" type="QString" value="0,0"/>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="offset_unit" type="QString" value="MM"/>
            <Option name="outline_color" type="QString" value="35,35,35,255"/>
            <Option name="outline_style" type="QString" value="solid"/>
            <Option name="outline_width" type="QString" value="0.2"/>
            <Option name="outline_width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="outline_width_unit" type="QString" value="MM"/>
            <Option name="scale_method" type="QString" value="diameter"/>
            <Option name="size" type="QString" value="5"/>
            <Option name="size_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="size_unit" type="QString" value="MM"/>
            <Option name="vertical_anchor_point" type="QString" value="1"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties" type="Map">
                <Option name="angle" type="Map">
                  <Option name="active" type="bool" value="true"/>
                  <Option name="expression" type="QString" value="&quot;direction&quot; + 45"/>
                  <Option name="type" type="int" value="3"/>
                </Option>
                <Option name="enabled" type="Map">
                  <Option name="active" type="bool" value="true"/>
                  <Option name="expression" type="QString" value="&quot;direction&quot; is not null"/>
                  <Option name="type" type="int" value="3"/>
                </Option>
                <Option name="fillColor" type="Map">
                  <Option name="active" type="bool" value="true"/>
                  <Option name="expression" type="QString" value="@PhotoView_Color"/>
                  <Option name="type" type="int" value="3"/>
                </Option>
              </Option>
              <Option name="type" type="QString" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer pass="0" enabled="1" locked="0" class="SimpleMarker">
          <Option type="Map">
            <Option name="angle" type="QString" value="0"/>
            <Option name="cap_style" type="QString" value="square"/>
            <Option name="color" type="QString" value="15,245,245,255"/>
            <Option name="horizontal_anchor_point" type="QString" value="1"/>
            <Option name="joinstyle" type="QString" value="bevel"/>
            <Option name="name" type="QString" value="circle"/>
            <Option name="offset" type="QString" value="0,0"/>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="offset_unit" type="QString" value="MM"/>
            <Option name="outline_color" type="QString" value="35,35,35,255"/>
            <Option name="outline_style" type="QString" value="solid"/>
            <Option name="outline_width" type="QString" value="0.2"/>
            <Option name="outline_width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="outline_width_unit" type="QString" value="MM"/>
            <Option name="scale_method" type="QString" value="diameter"/>
            <Option name="size" type="QString" value="2"/>
            <Option name="size_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="size_unit" type="QString" value="MM"/>
            <Option name="vertical_anchor_point" type="QString" value="1"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties" type="Map">
                <Option name="angle" type="Map">
                  <Option name="active" type="bool" value="false"/>
                  <Option name="type" type="int" value="1"/>
                  <Option name="val" type="QString" value=""/>
                </Option>
                <Option name="enabled" type="Map">
                  <Option name="active" type="bool" value="true"/>
                  <Option name="expression" type="QString" value="&quot;direction&quot; is null"/>
                  <Option name="type" type="int" value="3"/>
                </Option>
                <Option name="fillColor" type="Map">
                  <Option name="active" type="bool" value="true"/>
                  <Option name="expression" type="QString" value="@PhotoView_Color"/>
                  <Option name="type" type="int" value="3"/>
                </Option>
              </Option>
              <Option name="type" type="QString" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer pass="5" enabled="1" locked="0" class="SimpleMarker">
          <Option type="Map">
            <Option name="angle" type="QString" value="0"/>
            <Option name="cap_style" type="QString" value="square"/>
            <Option name="color" type="QString" value="0,0,0,255"/>
            <Option name="horizontal_anchor_point" type="QString" value="1"/>
            <Option name="joinstyle" type="QString" value="bevel"/>
            <Option name="name" type="QString" value="circle"/>
            <Option name="offset" type="QString" value="0,0"/>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="offset_unit" type="QString" value="MM"/>
            <Option name="outline_color" type="QString" value="35,35,35,255"/>
            <Option name="outline_style" type="QString" value="no"/>
            <Option name="outline_width" type="QString" value="0"/>
            <Option name="outline_width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="outline_width_unit" type="QString" value="MM"/>
            <Option name="scale_method" type="QString" value="diameter"/>
            <Option name="size" type="QString" value="0.6"/>
            <Option name="size_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="size_unit" type="QString" value="MM"/>
            <Option name="vertical_anchor_point" type="QString" value="1"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties" type="Map">
                <Option name="angle" type="Map">
                  <Option name="active" type="bool" value="false"/>
                  <Option name="expression" type="QString" value=""/>
                  <Option name="type" type="int" value="3"/>
                </Option>
              </Option>
              <Option name="type" type="QString" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer pass="7" enabled="1" locked="0" class="GeometryGenerator">
          <Option type="Map">
            <Option name="SymbolType" type="QString" value="Marker"/>
            <Option name="geometryModifier" type="QString" value="/*&#xd;&#xa;ラスタ画像マーカーのアンカー位置、ラベルのアンカー位置　共通&#xd;&#xa;*/&#xd;&#xa;with_variable('para',map(&#xd;&#xa; 'Number',  to_int( coalesce(@PhotoView_Number , 8) *if( @qgis_platform&lt;>'mobile',1,if( @map_extent_width > @map_extent_height ,1, @map_extent_width / @map_extent_height ))) ,&#xd;&#xa; 'TopMargin', to_real(coalesce(@PhotoView_TopMargin ,6.0))*@map_scale/1000,&#xd;&#xa; 'SideMargin', if( @qgis_platform='mobile',9,1) * @map_scale / 1000,&#xd;&#xa; 'PhotoByGap', 15.0),&#xd;&#xa;with_variable('Gap',(@map_extent_width - @para['SideMargin']*2) /((@para['PhotoByGap']+1)*@para['Number']-1),&#xd;&#xa;with_variable('Extent',intersection(  @map_extent , translate(  @map_extent ,0,-@para['PhotoByGap']*@Gap*0.800-@para['TopMargin'])),&#xd;&#xa;with_variable('i',  --左から何番目か&#xd;&#xa; array_find(&#xd;&#xa;  array_foreach(&#xd;&#xa;    array_sort(&#xd;&#xa;&#x9; array_foreach( &#xd;&#xa;  &#x9;  array_slice(&#xd;&#xa;       array_sort( &#xd;&#xa;        array_agg(  array(  distance(  @map_extent_center , $geometry ),$id ,$x ) ,filter:=if( attribute(  'invisible' ),false,true) and within(   $geometry , @Extent ))&#xd;&#xa;        )&#xd;&#xa;      ,0,@para['Number']-1)&#xd;&#xa;&#x9;, array_reverse(@element))&#xd;&#xa;    )&#xd;&#xa;  ,@element[1])&#xd;&#xa; ,$id),&#x9;&#x9;-- i の定義終わり&#xd;&#xa; with_variable('p0',translate(@map_extent_center,@para['SideMargin']+(@para['PhotoByGap']/2)*@Gap-@map_extent_width/2,&#xd;&#xa;  @map_extent_height/2-@para['TopMargin']),&#xd;&#xa; translate(@p0,(1+@para['PhotoByGap'])*@Gap*@i,0)&#xd;&#xa;)))))&#xd;&#xa;"/>
            <Option name="units" type="QString" value="MapUnit"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties"/>
              <Option name="type" type="QString" value="collection"/>
            </Option>
          </data_defined_properties>
          <symbol alpha="1" frame_rate="10" clip_to_extent="1" force_rhr="0" is_animated="0" name="@0@4" type="marker">
            <data_defined_properties>
              <Option type="Map">
                <Option name="name" type="QString" value=""/>
                <Option name="properties"/>
                <Option name="type" type="QString" value="collection"/>
              </Option>
            </data_defined_properties>
            <layer pass="0" enabled="1" locked="0" class="RasterMarker">
              <Option type="Map">
                <Option name="alpha" type="QString" value="1"/>
                <Option name="angle" type="QString" value="0"/>
                <Option name="fixedAspectRatio" type="QString" value="0"/>
                <Option name="horizontal_anchor_point" type="QString" value="1"/>
                <Option name="imageFile" type="QString" value=""/>
                <Option name="offset" type="QString" value="0,0"/>
                <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
                <Option name="offset_unit" type="QString" value="MM"/>
                <Option name="scale_method" type="QString" value="diameter"/>
                <Option name="size" type="QString" value="2"/>
                <Option name="size_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
                <Option name="size_unit" type="QString" value="MapUnit"/>
                <Option name="vertical_anchor_point" type="QString" value="0"/>
              </Option>
              <effect enabled="1" type="effectStack">
                <effect type="dropShadow">
                  <Option type="Map">
                    <Option name="blend_mode" type="QString" value="13"/>
                    <Option name="blur_level" type="QString" value="2.645"/>
                    <Option name="blur_unit" type="QString" value="MM"/>
                    <Option name="blur_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
                    <Option name="color" type="QString" value="0,0,0,255"/>
                    <Option name="draw_mode" type="QString" value="2"/>
                    <Option name="enabled" type="QString" value="0"/>
                    <Option name="offset_angle" type="QString" value="135"/>
                    <Option name="offset_distance" type="QString" value="2"/>
                    <Option name="offset_unit" type="QString" value="MM"/>
                    <Option name="offset_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
                    <Option name="opacity" type="QString" value="1"/>
                  </Option>
                </effect>
                <effect type="outerGlow">
                  <Option type="Map">
                    <Option name="blend_mode" type="QString" value="0"/>
                    <Option name="blur_level" type="QString" value="0.5"/>
                    <Option name="blur_unit" type="QString" value="MM"/>
                    <Option name="blur_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
                    <Option name="color1" type="QString" value="0,0,255,255"/>
                    <Option name="color2" type="QString" value="0,255,0,255"/>
                    <Option name="color_type" type="QString" value="0"/>
                    <Option name="direction" type="QString" value="ccw"/>
                    <Option name="discrete" type="QString" value="0"/>
                    <Option name="draw_mode" type="QString" value="2"/>
                    <Option name="enabled" type="QString" value="1"/>
                    <Option name="opacity" type="QString" value="0.5"/>
                    <Option name="rampType" type="QString" value="gradient"/>
                    <Option name="single_color" type="QString" value="255,255,255,255"/>
                    <Option name="spec" type="QString" value="rgb"/>
                    <Option name="spread" type="QString" value="1"/>
                    <Option name="spread_unit" type="QString" value="MM"/>
                    <Option name="spread_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
                  </Option>
                </effect>
                <effect type="drawSource">
                  <Option type="Map">
                    <Option name="blend_mode" type="QString" value="0"/>
                    <Option name="draw_mode" type="QString" value="2"/>
                    <Option name="enabled" type="QString" value="1"/>
                    <Option name="opacity" type="QString" value="1"/>
                  </Option>
                </effect>
                <effect type="innerShadow">
                  <Option type="Map">
                    <Option name="blend_mode" type="QString" value="13"/>
                    <Option name="blur_level" type="QString" value="2.645"/>
                    <Option name="blur_unit" type="QString" value="MM"/>
                    <Option name="blur_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
                    <Option name="color" type="QString" value="0,0,0,255"/>
                    <Option name="draw_mode" type="QString" value="2"/>
                    <Option name="enabled" type="QString" value="0"/>
                    <Option name="offset_angle" type="QString" value="135"/>
                    <Option name="offset_distance" type="QString" value="2"/>
                    <Option name="offset_unit" type="QString" value="MM"/>
                    <Option name="offset_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
                    <Option name="opacity" type="QString" value="1"/>
                  </Option>
                </effect>
                <effect type="innerGlow">
                  <Option type="Map">
                    <Option name="blend_mode" type="QString" value="0"/>
                    <Option name="blur_level" type="QString" value="2.645"/>
                    <Option name="blur_unit" type="QString" value="MM"/>
                    <Option name="blur_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
                    <Option name="color1" type="QString" value="0,0,255,255"/>
                    <Option name="color2" type="QString" value="0,255,0,255"/>
                    <Option name="color_type" type="QString" value="0"/>
                    <Option name="direction" type="QString" value="ccw"/>
                    <Option name="discrete" type="QString" value="0"/>
                    <Option name="draw_mode" type="QString" value="2"/>
                    <Option name="enabled" type="QString" value="0"/>
                    <Option name="opacity" type="QString" value="0.5"/>
                    <Option name="rampType" type="QString" value="gradient"/>
                    <Option name="single_color" type="QString" value="255,255,255,255"/>
                    <Option name="spec" type="QString" value="rgb"/>
                    <Option name="spread" type="QString" value="2"/>
                    <Option name="spread_unit" type="QString" value="MM"/>
                    <Option name="spread_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
                  </Option>
                </effect>
              </effect>
              <data_defined_properties>
                <Option type="Map">
                  <Option name="name" type="QString" value=""/>
                  <Option name="properties" type="Map">
                    <Option name="name" type="Map">
                      <Option name="active" type="bool" value="true"/>
                      <Option name="expression" type="QString" value="/*&#xd;&#xa;写真ファイルへのパス&#xd;&#xa;photo 絶対パス（ジオタグ付き写真の出力&#xd;&#xa;relpath　プロジェクトフォルダからの相対パス&#xd;&#xa;*/&#xd;&#xa;&#xd;&#xa;replace(&#xd;&#xa;&#x9;CASE &#xd;&#xa;&#x9;WHEN file_exists(attribute( 'photo')) THEN attribute( 'photo')&#xd;&#xa;&#x9;ELSE &#xd;&#xa;&#x9; @project_folder  || '/' || attribute('relpath')&#xd;&#xa;&#x9;END&#xd;&#xa;, '\\','/')"/>
                      <Option name="type" type="int" value="3"/>
                    </Option>
                    <Option name="width" type="Map">
                      <Option name="active" type="bool" value="true"/>
                      <Option name="expression" type="QString" value="/*&#xd;&#xa;写真の幅　地理単位(m)&#xd;&#xa;　写真数、左右端の余白、写真と写真間隔の比　により写真の幅を決定&#xd;&#xa;　デスクトップ（モバイル以外）　左右端の余白は1mm&#xd;&#xa;　モバイル　左右端の余白は9mm ボタンの幅をとるため、横向きはデスクトップと同じ写真数、縦は縦横比により減らす。&#xd;&#xa;*/&#xd;&#xa;&#xd;&#xa;with_variable('para',map(&#xd;&#xa; 'Number',  to_int( coalesce(@PhotoView_Number , 8) *if( @qgis_platform&lt;>'mobile',1,if( @map_extent_width > @map_extent_height ,1, @map_extent_width / @map_extent_height ))) ,&#xd;&#xa; 'TopMargin', to_real(coalesce(@PhotoView_TopMargin ,6.0)+if( @qgis_platform='mobile',3,0))*@map_scale/1000,&#xd;&#xa; 'SideMargin', if( @qgis_platform='mobile',9,1) * @map_scale / 1000,&#xd;&#xa; 'PhotoByGap', 15.0),&#xd;&#xa;with_variable('Gap',(@map_extent_width - @para['SideMargin']*2) /((@para['PhotoByGap']+1)*@para['Number']-1),&#xd;&#xa;&#x9;@para['PhotoByGap']*@Gap)&#xd;&#xa;)"/>
                      <Option name="type" type="int" value="3"/>
                    </Option>
                  </Option>
                  <Option name="type" type="QString" value="collection"/>
                </Option>
              </data_defined_properties>
            </layer>
          </symbol>
        </layer>
      </symbol>
      <symbol alpha="0.6" frame_rate="10" clip_to_extent="1" force_rhr="0" is_animated="0" name="1" type="marker">
        <data_defined_properties>
          <Option type="Map">
            <Option name="name" type="QString" value=""/>
            <Option name="properties"/>
            <Option name="type" type="QString" value="collection"/>
          </Option>
        </data_defined_properties>
        <layer pass="2" enabled="1" locked="0" class="SimpleMarker">
          <Option type="Map">
            <Option name="angle" type="QString" value="0"/>
            <Option name="cap_style" type="QString" value="square"/>
            <Option name="color" type="QString" value="255,255,255,255"/>
            <Option name="horizontal_anchor_point" type="QString" value="1"/>
            <Option name="joinstyle" type="QString" value="bevel"/>
            <Option name="name" type="QString" value="quarter_circle"/>
            <Option name="offset" type="QString" value="0,0"/>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="offset_unit" type="QString" value="MM"/>
            <Option name="outline_color" type="QString" value="35,35,35,255"/>
            <Option name="outline_style" type="QString" value="solid"/>
            <Option name="outline_width" type="QString" value="0"/>
            <Option name="outline_width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="outline_width_unit" type="QString" value="MM"/>
            <Option name="scale_method" type="QString" value="diameter"/>
            <Option name="size" type="QString" value="5"/>
            <Option name="size_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="size_unit" type="QString" value="MM"/>
            <Option name="vertical_anchor_point" type="QString" value="1"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties" type="Map">
                <Option name="angle" type="Map">
                  <Option name="active" type="bool" value="true"/>
                  <Option name="expression" type="QString" value="&quot;direction&quot; + 45"/>
                  <Option name="type" type="int" value="3"/>
                </Option>
                <Option name="enabled" type="Map">
                  <Option name="active" type="bool" value="true"/>
                  <Option name="expression" type="QString" value="&quot;direction&quot; is not null"/>
                  <Option name="type" type="int" value="3"/>
                </Option>
              </Option>
              <Option name="type" type="QString" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer pass="0" enabled="1" locked="0" class="SimpleMarker">
          <Option type="Map">
            <Option name="angle" type="QString" value="0"/>
            <Option name="cap_style" type="QString" value="square"/>
            <Option name="color" type="QString" value="255,255,255,255"/>
            <Option name="horizontal_anchor_point" type="QString" value="1"/>
            <Option name="joinstyle" type="QString" value="bevel"/>
            <Option name="name" type="QString" value="circle"/>
            <Option name="offset" type="QString" value="0,0"/>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="offset_unit" type="QString" value="MM"/>
            <Option name="outline_color" type="QString" value="35,35,35,255"/>
            <Option name="outline_style" type="QString" value="solid"/>
            <Option name="outline_width" type="QString" value="0"/>
            <Option name="outline_width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="outline_width_unit" type="QString" value="MM"/>
            <Option name="scale_method" type="QString" value="diameter"/>
            <Option name="size" type="QString" value="2"/>
            <Option name="size_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="size_unit" type="QString" value="MM"/>
            <Option name="vertical_anchor_point" type="QString" value="1"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties" type="Map">
                <Option name="angle" type="Map">
                  <Option name="active" type="bool" value="false"/>
                  <Option name="type" type="int" value="1"/>
                  <Option name="val" type="QString" value=""/>
                </Option>
                <Option name="enabled" type="Map">
                  <Option name="active" type="bool" value="true"/>
                  <Option name="expression" type="QString" value="&quot;direction&quot; is null"/>
                  <Option name="type" type="int" value="3"/>
                </Option>
              </Option>
              <Option name="type" type="QString" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer pass="3" enabled="1" locked="0" class="SimpleMarker">
          <Option type="Map">
            <Option name="angle" type="QString" value="0"/>
            <Option name="cap_style" type="QString" value="square"/>
            <Option name="color" type="QString" value="0,0,0,255"/>
            <Option name="horizontal_anchor_point" type="QString" value="1"/>
            <Option name="joinstyle" type="QString" value="bevel"/>
            <Option name="name" type="QString" value="circle"/>
            <Option name="offset" type="QString" value="0,0"/>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="offset_unit" type="QString" value="MM"/>
            <Option name="outline_color" type="QString" value="35,35,35,255"/>
            <Option name="outline_style" type="QString" value="no"/>
            <Option name="outline_width" type="QString" value="0"/>
            <Option name="outline_width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="outline_width_unit" type="QString" value="MM"/>
            <Option name="scale_method" type="QString" value="diameter"/>
            <Option name="size" type="QString" value="0.75"/>
            <Option name="size_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="size_unit" type="QString" value="MM"/>
            <Option name="vertical_anchor_point" type="QString" value="1"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties" type="Map">
                <Option name="angle" type="Map">
                  <Option name="active" type="bool" value="false"/>
                  <Option name="type" type="int" value="1"/>
                  <Option name="val" type="QString" value=""/>
                </Option>
              </Option>
              <Option name="type" type="QString" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
      <symbol alpha="0.6" frame_rate="10" clip_to_extent="1" force_rhr="0" is_animated="0" name="2" type="marker">
        <data_defined_properties>
          <Option type="Map">
            <Option name="name" type="QString" value=""/>
            <Option name="properties"/>
            <Option name="type" type="QString" value="collection"/>
          </Option>
        </data_defined_properties>
        <layer pass="0" enabled="1" locked="0" class="SimpleMarker">
          <Option type="Map">
            <Option name="angle" type="QString" value="0"/>
            <Option name="cap_style" type="QString" value="square"/>
            <Option name="color" type="QString" value="179,179,179,255"/>
            <Option name="horizontal_anchor_point" type="QString" value="1"/>
            <Option name="joinstyle" type="QString" value="bevel"/>
            <Option name="name" type="QString" value="quarter_circle"/>
            <Option name="offset" type="QString" value="0,0"/>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="offset_unit" type="QString" value="MM"/>
            <Option name="outline_color" type="QString" value="35,35,35,255"/>
            <Option name="outline_style" type="QString" value="solid"/>
            <Option name="outline_width" type="QString" value="0"/>
            <Option name="outline_width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="outline_width_unit" type="QString" value="MM"/>
            <Option name="scale_method" type="QString" value="diameter"/>
            <Option name="size" type="QString" value="5"/>
            <Option name="size_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="size_unit" type="QString" value="MM"/>
            <Option name="vertical_anchor_point" type="QString" value="1"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties" type="Map">
                <Option name="angle" type="Map">
                  <Option name="active" type="bool" value="true"/>
                  <Option name="expression" type="QString" value="&quot;direction&quot; + 45"/>
                  <Option name="type" type="int" value="3"/>
                </Option>
                <Option name="enabled" type="Map">
                  <Option name="active" type="bool" value="true"/>
                  <Option name="expression" type="QString" value="&quot;direction&quot; is not null"/>
                  <Option name="type" type="int" value="3"/>
                </Option>
              </Option>
              <Option name="type" type="QString" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer pass="0" enabled="1" locked="0" class="SimpleMarker">
          <Option type="Map">
            <Option name="angle" type="QString" value="0"/>
            <Option name="cap_style" type="QString" value="square"/>
            <Option name="color" type="QString" value="179,179,179,255"/>
            <Option name="horizontal_anchor_point" type="QString" value="1"/>
            <Option name="joinstyle" type="QString" value="bevel"/>
            <Option name="name" type="QString" value="circle"/>
            <Option name="offset" type="QString" value="0,0"/>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="offset_unit" type="QString" value="MM"/>
            <Option name="outline_color" type="QString" value="35,35,35,255"/>
            <Option name="outline_style" type="QString" value="solid"/>
            <Option name="outline_width" type="QString" value="0"/>
            <Option name="outline_width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="outline_width_unit" type="QString" value="MM"/>
            <Option name="scale_method" type="QString" value="diameter"/>
            <Option name="size" type="QString" value="2"/>
            <Option name="size_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="size_unit" type="QString" value="MM"/>
            <Option name="vertical_anchor_point" type="QString" value="1"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties" type="Map">
                <Option name="angle" type="Map">
                  <Option name="active" type="bool" value="false"/>
                  <Option name="type" type="int" value="1"/>
                  <Option name="val" type="QString" value=""/>
                </Option>
                <Option name="enabled" type="Map">
                  <Option name="active" type="bool" value="true"/>
                  <Option name="expression" type="QString" value="&quot;direction&quot; is null"/>
                  <Option name="type" type="int" value="3"/>
                </Option>
              </Option>
              <Option name="type" type="QString" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
        <layer pass="1" enabled="1" locked="0" class="SimpleMarker">
          <Option type="Map">
            <Option name="angle" type="QString" value="0"/>
            <Option name="cap_style" type="QString" value="square"/>
            <Option name="color" type="QString" value="0,0,0,255"/>
            <Option name="horizontal_anchor_point" type="QString" value="1"/>
            <Option name="joinstyle" type="QString" value="bevel"/>
            <Option name="name" type="QString" value="circle"/>
            <Option name="offset" type="QString" value="0,0"/>
            <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="offset_unit" type="QString" value="MM"/>
            <Option name="outline_color" type="QString" value="35,35,35,255"/>
            <Option name="outline_style" type="QString" value="no"/>
            <Option name="outline_width" type="QString" value="0"/>
            <Option name="outline_width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="outline_width_unit" type="QString" value="MM"/>
            <Option name="scale_method" type="QString" value="diameter"/>
            <Option name="size" type="QString" value="0.75"/>
            <Option name="size_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
            <Option name="size_unit" type="QString" value="MM"/>
            <Option name="vertical_anchor_point" type="QString" value="1"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties" type="Map">
                <Option name="angle" type="Map">
                  <Option name="active" type="bool" value="false"/>
                  <Option name="type" type="int" value="1"/>
                  <Option name="val" type="QString" value=""/>
                </Option>
              </Option>
              <Option name="type" type="QString" value="collection"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </symbols>
  </renderer-v2>
  <labeling type="rule-based">
    <rules key="{59d48c54-df07-4311-86f4-975d0535e57d}">
      <rule filter="/*&#xd;&#xa;写真表示地物かの条件判定　シンボロジ、ラベル共通&#xd;&#xa;*/&#xd;&#xa;with_variable('para',map(&#xd;&#xa; 'Number',  to_int( coalesce(@PhotoView_Number , 8) *if( @qgis_platform&lt;>'mobile',1,if( @map_extent_width > @map_extent_height ,1, @map_extent_width / @map_extent_height ))) ,&#xd;&#xa; 'TopMargin', to_real(coalesce(@PhotoView_TopMargin ,6.0)+if( @qgis_platform='mobile',3,0))*@map_scale/1000,&#xd;&#xa; 'SideMargin', if( @qgis_platform='mobile',9,1) * @map_scale / 1000,&#xd;&#xa; 'PhotoByGap', 15.0),&#xd;&#xa;with_variable('Gap',(@map_extent_width - @para['SideMargin']*2) /((@para['PhotoByGap']+1)*@para['Number']-1),&#xd;&#xa;with_variable('Extent',&#xd;&#xa;&#x9; intersection(  @map_extent , translate(  @map_extent ,0,-@para['PhotoByGap']*@Gap*0.800-@para['TopMargin'])),&#xd;&#xa;CASE &#xd;&#xa;WHEN  @map_rotation &lt;> 0 THEN false&#xd;&#xa;WHEN  attribute(  'invisible' ) THEN false&#xd;&#xa;WHEN  not within(   $geometry , @Extent )  THEN false&#xd;&#xa;ELSE&#xd;&#xa;with_variable('DistRank', array_find(&#xd;&#xa;&#x9; array_foreach(&#xd;&#xa;&#x9;array_sort( &#xd;&#xa;&#x9;&#x9;array_agg(  array(  distance(  @map_extent_center , $geometry ),$id  ) ,filter:=if( attribute(  'invisible' ),false,true) and within(   $geometry , @Extent ))&#xd;&#xa;&#x9;),&#xd;&#xa;&#x9;@element[1])&#xd;&#xa;&#x9;,$id),&#xd;&#xa;@DistRank&lt;@para['Number'])&#xd;&#xa;END&#xd;&#xa;)))" description="Photo" key="{cd18465a-c381-4e8f-b7b9-65dd9951c1cd}">
        <settings calloutType="simple">
          <text-style fontSizeMapUnitScale="3x:0,0,0,0,0,0" fontWordSpacing="0" forcedBold="0" namedStyle="Regular" fontWeight="50" previewBkgrdColor="255,255,255,255" fontSizeUnit="MapUnit" fontFamily="Arial" multilineHeightUnit="Percentage" capitalization="0" textOrientation="horizontal" fontKerning="1" textColor="0,0,255,255" allowHtml="0" isExpression="1" fontLetterSpacing="0" fontStrikeout="0" fontSize="10" fontItalic="0" useSubstitutions="0" fontUnderline="0" textOpacity="1" legendString="Aa" forcedItalic="0" fieldName="coalesce(  attribute( 'label') , attribute('filename') ) " blendMode="0" multilineHeight="1">
            <families/>
            <text-buffer bufferJoinStyle="128" bufferNoFill="1" bufferSizeUnits="MM" bufferColor="250,250,250,255" bufferBlendMode="0" bufferSize="0.59999999999999998" bufferSizeMapUnitScale="3x:0,0,0,0,0,0" bufferOpacity="1" bufferDraw="1"/>
            <text-mask maskEnabled="0" maskSizeMapUnitScale="3x:0,0,0,0,0,0" maskJoinStyle="128" maskType="0" maskSize="0" maskedSymbolLayers="" maskSizeUnits="MM" maskOpacity="1"/>
            <background shapeSizeMapUnitScale="3x:0,0,0,0,0,0" shapeDraw="0" shapeBorderWidthUnit="Point" shapeJoinStyle="64" shapeRadiiX="0" shapeOffsetX="0" shapeSizeType="0" shapeBorderWidthMapUnitScale="3x:0,0,0,0,0,0" shapeBorderColor="128,128,128,255" shapeOpacity="1" shapeSVGFile="" shapeRadiiY="0" shapeOffsetY="0" shapeRotation="0" shapeSizeUnit="Point" shapeSizeX="0" shapeSizeY="0" shapeType="0" shapeFillColor="255,255,255,255" shapeBorderWidth="0" shapeRadiiMapUnitScale="3x:0,0,0,0,0,0" shapeRadiiUnit="Point" shapeOffsetUnit="Point" shapeOffsetMapUnitScale="3x:0,0,0,0,0,0" shapeBlendMode="0" shapeRotationType="0">
              <symbol alpha="1" frame_rate="10" clip_to_extent="1" force_rhr="0" is_animated="0" name="markerSymbol" type="marker">
                <data_defined_properties>
                  <Option type="Map">
                    <Option name="name" type="QString" value=""/>
                    <Option name="properties"/>
                    <Option name="type" type="QString" value="collection"/>
                  </Option>
                </data_defined_properties>
                <layer pass="0" enabled="1" locked="0" class="SimpleMarker">
                  <Option type="Map">
                    <Option name="angle" type="QString" value="0"/>
                    <Option name="cap_style" type="QString" value="square"/>
                    <Option name="color" type="QString" value="243,166,178,255"/>
                    <Option name="horizontal_anchor_point" type="QString" value="1"/>
                    <Option name="joinstyle" type="QString" value="bevel"/>
                    <Option name="name" type="QString" value="circle"/>
                    <Option name="offset" type="QString" value="0,0"/>
                    <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
                    <Option name="offset_unit" type="QString" value="MM"/>
                    <Option name="outline_color" type="QString" value="35,35,35,255"/>
                    <Option name="outline_style" type="QString" value="solid"/>
                    <Option name="outline_width" type="QString" value="0"/>
                    <Option name="outline_width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
                    <Option name="outline_width_unit" type="QString" value="MM"/>
                    <Option name="scale_method" type="QString" value="diameter"/>
                    <Option name="size" type="QString" value="2"/>
                    <Option name="size_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
                    <Option name="size_unit" type="QString" value="MM"/>
                    <Option name="vertical_anchor_point" type="QString" value="1"/>
                  </Option>
                  <data_defined_properties>
                    <Option type="Map">
                      <Option name="name" type="QString" value=""/>
                      <Option name="properties"/>
                      <Option name="type" type="QString" value="collection"/>
                    </Option>
                  </data_defined_properties>
                </layer>
              </symbol>
              <symbol alpha="1" frame_rate="10" clip_to_extent="1" force_rhr="0" is_animated="0" name="fillSymbol" type="fill">
                <data_defined_properties>
                  <Option type="Map">
                    <Option name="name" type="QString" value=""/>
                    <Option name="properties"/>
                    <Option name="type" type="QString" value="collection"/>
                  </Option>
                </data_defined_properties>
                <layer pass="0" enabled="1" locked="0" class="SimpleFill">
                  <Option type="Map">
                    <Option name="border_width_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
                    <Option name="color" type="QString" value="255,255,255,255"/>
                    <Option name="joinstyle" type="QString" value="bevel"/>
                    <Option name="offset" type="QString" value="0,0"/>
                    <Option name="offset_map_unit_scale" type="QString" value="3x:0,0,0,0,0,0"/>
                    <Option name="offset_unit" type="QString" value="MM"/>
                    <Option name="outline_color" type="QString" value="128,128,128,255"/>
                    <Option name="outline_style" type="QString" value="no"/>
                    <Option name="outline_width" type="QString" value="0"/>
                    <Option name="outline_width_unit" type="QString" value="Point"/>
                    <Option name="style" type="QString" value="solid"/>
                  </Option>
                  <data_defined_properties>
                    <Option type="Map">
                      <Option name="name" type="QString" value=""/>
                      <Option name="properties"/>
                      <Option name="type" type="QString" value="collection"/>
                    </Option>
                  </data_defined_properties>
                </layer>
              </symbol>
            </background>
            <shadow shadowRadiusMapUnitScale="3x:0,0,0,0,0,0" shadowOffsetAngle="135" shadowOffsetGlobal="1" shadowOpacity="0.69999999999999996" shadowOffsetMapUnitScale="3x:0,0,0,0,0,0" shadowColor="0,0,0,255" shadowScale="100" shadowUnder="0" shadowOffsetDist="1" shadowOffsetUnit="MM" shadowRadiusUnit="MM" shadowBlendMode="6" shadowRadiusAlphaOnly="0" shadowDraw="0" shadowRadius="1.5"/>
            <dd_properties>
              <Option type="Map">
                <Option name="name" type="QString" value=""/>
                <Option name="properties"/>
                <Option name="type" type="QString" value="collection"/>
              </Option>
            </dd_properties>
            <substitutions/>
          </text-style>
          <text-format reverseDirectionSymbol="0" leftDirectionSymbol="&lt;" formatNumbers="0" decimals="3" plussign="0" wrapChar="" addDirectionSymbol="0" useMaxLineLengthForAutoWrap="1" placeDirectionSymbol="0" rightDirectionSymbol=">" autoWrapLength="0" multilineAlign="3"/>
          <placement maxCurvedCharAngleOut="-25" lineAnchorClipping="0" geometryGenerator="/*&#xd;&#xa;ラスタ画像マーカーのアンカー位置、ラベルのアンカー位置　共通&#xd;&#xa;*/&#xd;&#xa;with_variable('para',map(&#xd;&#xa; 'Number',  to_int( coalesce(@PhotoView_Number , 8) *if( @qgis_platform&lt;>'mobile',1,if( @map_extent_width > @map_extent_height ,1, @map_extent_width / @map_extent_height ))) ,&#xd;&#xa; 'TopMargin', to_real(coalesce(@PhotoView_TopMargin ,6.0))*@map_scale/1000,&#xd;&#xa; 'SideMargin', if( @qgis_platform='mobile',9,1) * @map_scale / 1000,&#xd;&#xa; 'PhotoByGap', 15.0),&#xd;&#xa;with_variable('Gap',(@map_extent_width - @para['SideMargin']*2) /((@para['PhotoByGap']+1)*@para['Number']-1),&#xd;&#xa;with_variable('Extent',intersection(  @map_extent , translate(  @map_extent ,0,-@para['PhotoByGap']*@Gap*0.800-@para['TopMargin'])),&#xd;&#xa;with_variable('i',  --左から何番目か&#xd;&#xa; array_find(&#xd;&#xa;  array_foreach(&#xd;&#xa;    array_sort(&#xd;&#xa;&#x9; array_foreach( &#xd;&#xa;  &#x9;  array_slice(&#xd;&#xa;       array_sort( &#xd;&#xa;        array_agg(  array(  distance(  @map_extent_center , $geometry ),$id ,$x ) ,filter:=if( attribute(  'invisible' ),false,true) and within(   $geometry , @Extent ))&#xd;&#xa;        )&#xd;&#xa;      ,0,@para['Number']-1)&#xd;&#xa;&#x9;, array_reverse(@element))&#xd;&#xa;    )&#xd;&#xa;  ,@element[1])&#xd;&#xa; ,$id),&#x9;&#x9;-- i の定義終わり&#xd;&#xa; with_variable('p0',translate(@map_extent_center,@para['SideMargin']+(@para['PhotoByGap']/2)*@Gap-@map_extent_width/2,&#xd;&#xa;  @map_extent_height/2-@para['TopMargin']),&#xd;&#xa; translate(@p0,(1+@para['PhotoByGap'])*@Gap*@i,0)&#xd;&#xa;)))))&#xd;&#xa;" repeatDistanceMapUnitScale="3x:0,0,0,0,0,0" lineAnchorTextPoint="CenterOfText" yOffset="0" fitInPolygonOnly="0" overrunDistance="0" distMapUnitScale="3x:0,0,0,0,0,0" overrunDistanceUnit="MM" predefinedPositionOrder="TR,TL,BR,BL,R,L,TSR,BSR" overlapHandling="PreventOverlap" rotationAngle="0" distUnits="MM" centroidInside="0" quadOffset="1" centroidWhole="0" lineAnchorType="0" polygonPlacementFlags="2" rotationUnit="AngleDegrees" dist="0" maxCurvedCharAngleIn="25" offsetUnits="MM" repeatDistance="0" repeatDistanceUnits="MM" placement="1" layerType="PointGeometry" xOffset="0" allowDegraded="0" placementFlags="10" overrunDistanceMapUnitScale="3x:0,0,0,0,0,0" labelOffsetMapUnitScale="3x:0,0,0,0,0,0" geometryGeneratorEnabled="1" geometryGeneratorType="PointGeometry" lineAnchorPercent="0.5" preserveRotation="1" priority="5" offsetType="1"/>
          <rendering minFeatureSize="0" labelPerPart="0" mergeLines="0" fontLimitPixelSize="0" scaleVisibility="0" obstacleType="1" scaleMin="0" obstacleFactor="1" fontMaxPixelSize="10000" unplacedVisibility="0" limitNumLabels="0" drawLabels="1" obstacle="1" zIndex="0" maxNumLabels="2000" upsidedownLabels="0" fontMinPixelSize="3" scaleMax="0"/>
          <dd_properties>
            <Option type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties" type="Map">
                <Option name="Color" type="Map">
                  <Option name="active" type="bool" value="true"/>
                  <Option name="expression" type="QString" value="darker( @PhotoView_Color,200)"/>
                  <Option name="type" type="int" value="3"/>
                </Option>
                <Option name="Size" type="Map">
                  <Option name="active" type="bool" value="true"/>
                  <Option name="expression" type="QString" value="/*&#xd;&#xa;ラベルの高さ&#xd;&#xa;文字数が多い場合、縮小する。&#xd;&#xa;プロポーショナルフォントは半角の幅が不定なので、幅を@SingleByteCaracterWidthで仮定する。&#xd;&#xa;*/&#xd;&#xa;&#xd;&#xa;with_variable('para',map(&#xd;&#xa; 'Number',  to_int( coalesce(@PhotoView_Number , 8) *if( @qgis_platform&lt;>'mobile',1,if( @map_extent_width > @map_extent_height ,1, @map_extent_width / @map_extent_height ))) ,&#xd;&#xa; 'TopMargin', to_real(coalesce(@PhotoView_TopMargin ,6.0))*@map_scale/1000,&#xd;&#xa; 'SideMargin', if( @qgis_platform='mobile',9,1) * @map_scale / 1000,&#xd;&#xa; 'PhotoByGap', 15.0),&#xd;&#xa;with_variable('Gap',(@map_extent_width - @para['SideMargin']*2) /((@para['PhotoByGap']+1)*@para['Number']-1),&#xd;&#xa;with_variable('SingleByteCaracterWidth',to_real(coalesce(@PhotoView_SingleByteCaracterWidth ,0.7)),&#xd;&#xa;with_variable('LabelSize', @para['TopMargin']-if(@qgis_platform='mobile',4,1)*@map_scale/1000,&#xd;&#xa;with_variable('PhotoWidth',@para['PhotoByGap']*@Gap,&#xd;&#xa;with_variable('StrLen',&#xd;&#xa;    eval( array_to_string(&#xd;&#xa;    array_foreach(&#xd;&#xa;        array_remove_all( string_to_array(coalesce(  attribute( 'label') , attribute('filename') )   ,''),''),&#xd;&#xa;    if(@element ~ '[ -~]',@SingleByteCaracterWidth,1))&#xd;&#xa;,'+'))&#xd;&#xa;,&#xd;&#xa;if(@PhotoWidth>@LabelSize*@StrLen,&#xd;&#xa;    @LabelSize,@PhotoWidth/@StrLen)&#xd;&#xa;))))))"/>
                  <Option name="type" type="int" value="3"/>
                </Option>
              </Option>
              <Option name="type" type="QString" value="collection"/>
            </Option>
          </dd_properties>
          <callout type="simple">
            <Option type="Map">
              <Option name="anchorPoint" type="QString" value="pole_of_inaccessibility"/>
              <Option name="blendMode" type="int" value="0"/>
              <Option name="ddProperties" type="Map">
                <Option name="name" type="QString" value=""/>
                <Option name="properties"/>
                <Option name="type" type="QString" value="collection"/>
              </Option>
              <Option name="drawToAllParts" type="bool" value="false"/>
              <Option name="enabled" type="QString" value="0"/>
              <Option name="labelAnchorPoint" type="QString" value="point_on_exterior"/>
              <Option name="lineSymbol" type="QString" value="&lt;symbol alpha=&quot;1&quot; frame_rate=&quot;10&quot; clip_to_extent=&quot;1&quot; force_rhr=&quot;0&quot; is_animated=&quot;0&quot; name=&quot;symbol&quot; type=&quot;line&quot;>&lt;data_defined_properties>&lt;Option type=&quot;Map&quot;>&lt;Option name=&quot;name&quot; type=&quot;QString&quot; value=&quot;&quot;/>&lt;Option name=&quot;properties&quot;/>&lt;Option name=&quot;type&quot; type=&quot;QString&quot; value=&quot;collection&quot;/>&lt;/Option>&lt;/data_defined_properties>&lt;layer pass=&quot;0&quot; enabled=&quot;1&quot; locked=&quot;0&quot; class=&quot;SimpleLine&quot;>&lt;Option type=&quot;Map&quot;>&lt;Option name=&quot;align_dash_pattern&quot; type=&quot;QString&quot; value=&quot;0&quot;/>&lt;Option name=&quot;capstyle&quot; type=&quot;QString&quot; value=&quot;square&quot;/>&lt;Option name=&quot;customdash&quot; type=&quot;QString&quot; value=&quot;5;2&quot;/>&lt;Option name=&quot;customdash_map_unit_scale&quot; type=&quot;QString&quot; value=&quot;3x:0,0,0,0,0,0&quot;/>&lt;Option name=&quot;customdash_unit&quot; type=&quot;QString&quot; value=&quot;MM&quot;/>&lt;Option name=&quot;dash_pattern_offset&quot; type=&quot;QString&quot; value=&quot;0&quot;/>&lt;Option name=&quot;dash_pattern_offset_map_unit_scale&quot; type=&quot;QString&quot; value=&quot;3x:0,0,0,0,0,0&quot;/>&lt;Option name=&quot;dash_pattern_offset_unit&quot; type=&quot;QString&quot; value=&quot;MM&quot;/>&lt;Option name=&quot;draw_inside_polygon&quot; type=&quot;QString&quot; value=&quot;0&quot;/>&lt;Option name=&quot;joinstyle&quot; type=&quot;QString&quot; value=&quot;bevel&quot;/>&lt;Option name=&quot;line_color&quot; type=&quot;QString&quot; value=&quot;60,60,60,255&quot;/>&lt;Option name=&quot;line_style&quot; type=&quot;QString&quot; value=&quot;solid&quot;/>&lt;Option name=&quot;line_width&quot; type=&quot;QString&quot; value=&quot;0.3&quot;/>&lt;Option name=&quot;line_width_unit&quot; type=&quot;QString&quot; value=&quot;MM&quot;/>&lt;Option name=&quot;offset&quot; type=&quot;QString&quot; value=&quot;0&quot;/>&lt;Option name=&quot;offset_map_unit_scale&quot; type=&quot;QString&quot; value=&quot;3x:0,0,0,0,0,0&quot;/>&lt;Option name=&quot;offset_unit&quot; type=&quot;QString&quot; value=&quot;MM&quot;/>&lt;Option name=&quot;ring_filter&quot; type=&quot;QString&quot; value=&quot;0&quot;/>&lt;Option name=&quot;trim_distance_end&quot; type=&quot;QString&quot; value=&quot;0&quot;/>&lt;Option name=&quot;trim_distance_end_map_unit_scale&quot; type=&quot;QString&quot; value=&quot;3x:0,0,0,0,0,0&quot;/>&lt;Option name=&quot;trim_distance_end_unit&quot; type=&quot;QString&quot; value=&quot;MM&quot;/>&lt;Option name=&quot;trim_distance_start&quot; type=&quot;QString&quot; value=&quot;0&quot;/>&lt;Option name=&quot;trim_distance_start_map_unit_scale&quot; type=&quot;QString&quot; value=&quot;3x:0,0,0,0,0,0&quot;/>&lt;Option name=&quot;trim_distance_start_unit&quot; type=&quot;QString&quot; value=&quot;MM&quot;/>&lt;Option name=&quot;tweak_dash_pattern_on_corners&quot; type=&quot;QString&quot; value=&quot;0&quot;/>&lt;Option name=&quot;use_custom_dash&quot; type=&quot;QString&quot; value=&quot;0&quot;/>&lt;Option name=&quot;width_map_unit_scale&quot; type=&quot;QString&quot; value=&quot;3x:0,0,0,0,0,0&quot;/>&lt;/Option>&lt;data_defined_properties>&lt;Option type=&quot;Map&quot;>&lt;Option name=&quot;name&quot; type=&quot;QString&quot; value=&quot;&quot;/>&lt;Option name=&quot;properties&quot;/>&lt;Option name=&quot;type&quot; type=&quot;QString&quot; value=&quot;collection&quot;/>&lt;/Option>&lt;/data_defined_properties>&lt;/layer>&lt;/symbol>"/>
              <Option name="minLength" type="double" value="0"/>
              <Option name="minLengthMapUnitScale" type="QString" value="3x:0,0,0,0,0,0"/>
              <Option name="minLengthUnit" type="QString" value="MM"/>
              <Option name="offsetFromAnchor" type="double" value="0"/>
              <Option name="offsetFromAnchorMapUnitScale" type="QString" value="3x:0,0,0,0,0,0"/>
              <Option name="offsetFromAnchorUnit" type="QString" value="MM"/>
              <Option name="offsetFromLabel" type="double" value="0"/>
              <Option name="offsetFromLabelMapUnitScale" type="QString" value="3x:0,0,0,0,0,0"/>
              <Option name="offsetFromLabelUnit" type="QString" value="MM"/>
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
    <field name="relpath" configurationFlags="None">
      <editWidget type="ExternalResource">
        <config>
          <Option type="Map">
            <Option name="DocumentViewer" type="int" value="1"/>
            <Option name="DocumentViewerHeight" type="int" value="0"/>
            <Option name="DocumentViewerWidth" type="int" value="0"/>
            <Option name="FileWidget" type="bool" value="true"/>
            <Option name="FileWidgetButton" type="bool" value="true"/>
            <Option name="FileWidgetFilter" type="QString" value=""/>
            <Option name="PropertyCollection" type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties" type="invalid"/>
              <Option name="type" type="QString" value="collection"/>
            </Option>
            <Option name="RelativeStorage" type="int" value="1"/>
            <Option name="StorageAuthConfigId" type="QString" value=""/>
            <Option name="StorageMode" type="int" value="0"/>
            <Option name="StorageType" type="QString" value=""/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="label" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" type="bool" value="false"/>
            <Option name="UseHtml" type="bool" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="invisible" configurationFlags="None">
      <editWidget type="CheckBox">
        <config>
          <Option type="Map">
            <Option name="CheckedState" type="QString" value=""/>
            <Option name="TextDisplayMethod" type="int" value="0"/>
            <Option name="UncheckedState" type="QString" value=""/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="timestamp" configurationFlags="None">
      <editWidget type="DateTime">
        <config>
          <Option type="Map">
            <Option name="allow_null" type="bool" value="true"/>
            <Option name="calendar_popup" type="bool" value="true"/>
            <Option name="display_format" type="QString" value="yyyy/MM/dd HH:mm:ss"/>
            <Option name="field_format" type="QString" value="yyyy/MM/dd HH:mm:ss"/>
            <Option name="field_iso_format" type="bool" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="direction" configurationFlags="None">
      <editWidget type="TextEdit">
        <config>
          <Option type="Map">
            <Option name="IsMultiline" type="bool" value="false"/>
            <Option name="UseHtml" type="bool" value="false"/>
          </Option>
        </config>
      </editWidget>
    </field>
    <field name="photo" configurationFlags="None">
      <editWidget type="ExternalResource">
        <config>
          <Option type="Map">
            <Option name="DocumentViewer" type="int" value="1"/>
            <Option name="DocumentViewerHeight" type="int" value="0"/>
            <Option name="DocumentViewerWidth" type="int" value="0"/>
            <Option name="FileWidget" type="bool" value="true"/>
            <Option name="FileWidgetButton" type="bool" value="true"/>
            <Option name="FileWidgetFilter" type="QString" value=""/>
            <Option name="PropertyCollection" type="Map">
              <Option name="name" type="QString" value=""/>
              <Option name="properties" type="invalid"/>
              <Option name="type" type="QString" value="collection"/>
            </Option>
            <Option name="RelativeStorage" type="int" value="0"/>
            <Option name="StorageAuthConfigId" type="QString" value=""/>
            <Option name="StorageMode" type="int" value="0"/>
            <Option name="StorageType" type="QString" value=""/>
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
  </fieldConfiguration>
  <aliases>
    <alias name="" index="0" field="fid"/>
    <alias name="" index="1" field="relpath"/>
    <alias name="" index="2" field="label"/>
    <alias name="" index="3" field="invisible"/>
    <alias name="" index="4" field="timestamp"/>
    <alias name="" index="5" field="direction"/>
    <alias name="" index="6" field="photo"/>
    <alias name="" index="7" field="filename"/>
    <alias name="" index="8" field="directory"/>
    <alias name="" index="9" field="altitude"/>
    <alias name="" index="10" field="rotation"/>
    <alias name="" index="11" field="longitude"/>
    <alias name="" index="12" field="latitude"/>
  </aliases>
  <defaults>
    <default applyOnUpdate="0" field="fid" expression=""/>
    <default applyOnUpdate="0" field="relpath" expression=""/>
    <default applyOnUpdate="0" field="label" expression=""/>
    <default applyOnUpdate="0" field="invisible" expression=""/>
    <default applyOnUpdate="0" field="timestamp" expression=""/>
    <default applyOnUpdate="0" field="direction" expression=""/>
    <default applyOnUpdate="0" field="photo" expression=""/>
    <default applyOnUpdate="0" field="filename" expression=""/>
    <default applyOnUpdate="0" field="directory" expression=""/>
    <default applyOnUpdate="0" field="altitude" expression=""/>
    <default applyOnUpdate="0" field="rotation" expression=""/>
    <default applyOnUpdate="0" field="longitude" expression=""/>
    <default applyOnUpdate="0" field="latitude" expression=""/>
  </defaults>
  <constraints>
    <constraint exp_strength="0" constraints="3" notnull_strength="1" unique_strength="1" field="fid"/>
    <constraint exp_strength="0" constraints="0" notnull_strength="0" unique_strength="0" field="relpath"/>
    <constraint exp_strength="0" constraints="0" notnull_strength="0" unique_strength="0" field="label"/>
    <constraint exp_strength="0" constraints="0" notnull_strength="0" unique_strength="0" field="invisible"/>
    <constraint exp_strength="0" constraints="0" notnull_strength="0" unique_strength="0" field="timestamp"/>
    <constraint exp_strength="0" constraints="0" notnull_strength="0" unique_strength="0" field="direction"/>
    <constraint exp_strength="0" constraints="0" notnull_strength="0" unique_strength="0" field="photo"/>
    <constraint exp_strength="0" constraints="0" notnull_strength="0" unique_strength="0" field="filename"/>
    <constraint exp_strength="0" constraints="0" notnull_strength="0" unique_strength="0" field="directory"/>
    <constraint exp_strength="0" constraints="0" notnull_strength="0" unique_strength="0" field="altitude"/>
    <constraint exp_strength="0" constraints="0" notnull_strength="0" unique_strength="0" field="rotation"/>
    <constraint exp_strength="0" constraints="0" notnull_strength="0" unique_strength="0" field="longitude"/>
    <constraint exp_strength="0" constraints="0" notnull_strength="0" unique_strength="0" field="latitude"/>
  </constraints>
  <constraintExpressions>
    <constraint desc="" field="fid" exp=""/>
    <constraint desc="" field="relpath" exp=""/>
    <constraint desc="" field="label" exp=""/>
    <constraint desc="" field="invisible" exp=""/>
    <constraint desc="" field="timestamp" exp=""/>
    <constraint desc="" field="direction" exp=""/>
    <constraint desc="" field="photo" exp=""/>
    <constraint desc="" field="filename" exp=""/>
    <constraint desc="" field="directory" exp=""/>
    <constraint desc="" field="altitude" exp=""/>
    <constraint desc="" field="rotation" exp=""/>
    <constraint desc="" field="longitude" exp=""/>
    <constraint desc="" field="latitude" exp=""/>
  </constraintExpressions>
  <expressionfields/>
  <attributeactions>
    <defaultAction key="Canvas" value="{f3d09ced-e2ce-4a35-956d-c1cb9c8ff1b8}"/>
    <actionsetting notificationMessage="" name="open" id="{f3d09ced-e2ce-4a35-956d-c1cb9c8ff1b8}" shortTitle="" icon="" isEnabledOnlyWhenEditable="0" action="[%replace(&#xd;&#xa; coalesce( attribute( 'photo'),&#xd;&#xa;  file_path( layer_property(  @layer ,'path')) || '/' || attribute('relpath')&#xd;&#xa; )&#xd;&#xa;, '\\','/')%]" type="5" capture="0">
      <actionScope id="Field"/>
      <actionScope id="Layer"/>
      <actionScope id="Feature"/>
      <actionScope id="Canvas"/>
    </actionsetting>
  </attributeactions>
  <attributetableconfig actionWidgetStyle="dropDown" sortExpression="" sortOrder="0">
    <columns>
      <column hidden="0" name="filename" type="field" width="-1"/>
      <column hidden="0" name="directory" type="field" width="-1"/>
      <column hidden="0" name="altitude" type="field" width="-1"/>
      <column hidden="0" name="direction" type="field" width="-1"/>
      <column hidden="0" name="rotation" type="field" width="-1"/>
      <column hidden="0" name="longitude" type="field" width="-1"/>
      <column hidden="0" name="latitude" type="field" width="-1"/>
      <column hidden="0" name="timestamp" type="field" width="-1"/>
      <column hidden="0" name="invisible" type="field" width="-1"/>
      <column hidden="0" name="label" type="field" width="-1"/>
      <column hidden="0" name="relpath" type="field" width="231"/>
      <column hidden="0" name="photo" type="field" width="-1"/>
      <column hidden="0" name="fid" type="field" width="-1"/>
      <column hidden="1" type="actions" width="-1"/>
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
    <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
      <labelFont bold="0" style="" underline="0" strikethrough="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0" italic="0"/>
    </labelStyle>
    <attributeEditorField name="fid" index="0" showLabel="1">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont bold="0" style="" underline="0" strikethrough="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0" italic="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="filename" index="7" showLabel="1">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont bold="0" style="" underline="0" strikethrough="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0" italic="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="directory" index="8" showLabel="1">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont bold="0" style="" underline="0" strikethrough="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0" italic="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="altitude" index="9" showLabel="1">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont bold="0" style="" underline="0" strikethrough="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0" italic="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="direction" index="5" showLabel="1">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont bold="0" style="" underline="0" strikethrough="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0" italic="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="rotation" index="10" showLabel="1">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont bold="0" style="" underline="0" strikethrough="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0" italic="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="longitude" index="11" showLabel="1">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont bold="0" style="" underline="0" strikethrough="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0" italic="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="latitude" index="12" showLabel="1">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont bold="0" style="" underline="0" strikethrough="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0" italic="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="timestamp" index="4" showLabel="1">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont bold="0" style="" underline="0" strikethrough="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0" italic="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="invisible" index="3" showLabel="1">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont bold="0" style="" underline="0" strikethrough="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0" italic="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="label" index="2" showLabel="1">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont bold="0" style="" underline="0" strikethrough="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0" italic="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorField name="relpath" index="1" showLabel="1">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont bold="0" style="" underline="0" strikethrough="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0" italic="0"/>
      </labelStyle>
    </attributeEditorField>
    <attributeEditorContainer visibilityExpression="&quot;filename&quot;" columnCount="2" collapsed="1" backgroundColor="#ff0000" name="tttt" collapsedExpression="" groupBox="1" visibilityExpressionEnabled="0" collapsedExpressionEnabled="0" showLabel="1">
      <labelStyle overrideLabelColor="0" labelColor="0,0,0,255" overrideLabelFont="0">
        <labelFont bold="0" style="" underline="0" strikethrough="0" description="MS UI Gothic,9,-1,5,50,0,0,0,0,0" italic="0"/>
      </labelStyle>
    </attributeEditorContainer>
  </attributeEditorForm>
  <editable>
    <field name="altitude" editable="1"/>
    <field name="direction" editable="1"/>
    <field name="directory" editable="1"/>
    <field name="fid" editable="1"/>
    <field name="filename" editable="1"/>
    <field name="invisible" editable="1"/>
    <field name="label" editable="1"/>
    <field name="latitude" editable="1"/>
    <field name="longitude" editable="1"/>
    <field name="photo" editable="1"/>
    <field name="relpath" editable="1"/>
    <field name="rotation" editable="1"/>
    <field name="timestamp" editable="1"/>
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
    <field name="altitude" reuseLastValue="0"/>
    <field name="direction" reuseLastValue="0"/>
    <field name="directory" reuseLastValue="0"/>
    <field name="fid" reuseLastValue="0"/>
    <field name="filename" reuseLastValue="0"/>
    <field name="invisible" reuseLastValue="0"/>
    <field name="label" reuseLastValue="0"/>
    <field name="latitude" reuseLastValue="0"/>
    <field name="longitude" reuseLastValue="0"/>
    <field name="photo" reuseLastValue="0"/>
    <field name="relpath" reuseLastValue="0"/>
    <field name="rotation" reuseLastValue="0"/>
    <field name="timestamp" reuseLastValue="0"/>
  </reuseLastValue>
  <dataDefinedFieldProperties/>
  <widgets/>
  <previewExpression>$id  || ' , ' || coalesce( "label" , "filename" )</previewExpression>
  <layerGeometryType>0</layerGeometryType>
</qgis>
