�m
��
D
AddV2
x"T
y"T
z"T"
Ttype:
2	��
^
AssignVariableOp
resource
value"dtype"
dtypetype"
validate_shapebool( �
8
Const
output"dtype"
valuetensor"
dtypetype
.
Identity

input"T
output"T"	
Ttype
e
MergeV2Checkpoints
checkpoint_prefixes
destination_prefix"
delete_old_dirsbool(�
?
Mul
x"T
y"T
z"T"
Ttype:
2	�

NoOp
M
Pack
values"T*N
output"T"
Nint(0"	
Ttype"
axisint 
C
Placeholder
output"dtype"
dtypetype"
shapeshape:
@
ReadVariableOp
resource
value"dtype"
dtypetype�
o
	RestoreV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0�
l
SaveV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0�
?
Select
	condition

t"T
e"T
output"T"	
Ttype
H
ShardedFilename
basename	
shard

num_shards
filename
�
StatefulPartitionedCall
args2Tin
output2Tout"
Tin
list(type)("
Tout
list(type)("	
ffunc"
configstring "
config_protostring "
executor_typestring ��
@
StaticRegexFullMatch	
input

output
"
patternstring
N

StringJoin
inputs*N

output"
Nint(0"
	separatorstring 
<
Sub
x"T
y"T
z"T"
Ttype:
2	
�
VarHandleOp
resource"
	containerstring "
shared_namestring "
dtypetype"
shapeshape"#
allowed_deviceslist(string)
 �"serve*2.9.02unknown8�S
h
var2VarHandleOp*
_output_shapes
: *
dtype0*
shape:*
shared_namevar2
a
var2/Read/ReadVariableOpReadVariableOpvar2*"
_output_shapes
:*
dtype0
h
var1VarHandleOp*
_output_shapes
: *
dtype0*
shape:*
shared_namevar1
a
var1/Read/ReadVariableOpReadVariableOpvar1*"
_output_shapes
:*
dtype0

NoOpNoOp
�
ConstConst"/device:CPU:0*
_output_shapes
: *
dtype0*�
value�B� B�
6
var1
var2
__call__

signatures*
=7
VARIABLE_VALUEvar1var1/.ATTRIBUTES/VARIABLE_VALUE*
=7
VARIABLE_VALUEvar2var2/.ATTRIBUTES/VARIABLE_VALUE*

trace_0* 

serving_default* 
* 
* 
�
serving_default_input1Placeholder*+
_output_shapes
:���������*
dtype0* 
shape:���������
�
serving_default_input2Placeholder*+
_output_shapes
:���������*
dtype0* 
shape:���������
�
StatefulPartitionedCallStatefulPartitionedCallserving_default_input1serving_default_input2var1var2*
Tin
2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:���������*$
_read_only_resource_inputs
*>
config_proto.,

CPU

GPU2*0,1,2,3,4,5,6,7J 8� *)
f$R"
 __inference_signature_wrapper_34
O
saver_filenamePlaceholder*
_output_shapes
: *
dtype0*
shape: 
�
StatefulPartitionedCall_1StatefulPartitionedCallsaver_filenamevar1/Read/ReadVariableOpvar2/Read/ReadVariableOpConst*
Tin
2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *>
config_proto.,

CPU

GPU2*0,1,2,3,4,5,6,7J 8� *$
fR
__inference__traced_save_79
�
StatefulPartitionedCall_2StatefulPartitionedCallsaver_filenamevar1var2*
Tin
2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *>
config_proto.,

CPU

GPU2*0,1,2,3,4,5,6,7J 8� *'
f"R 
__inference__traced_restore_95�C
�
�
__inference__traced_save_79
file_prefix#
savev2_var1_read_readvariableop#
savev2_var2_read_readvariableop
savev2_const

identity_1��MergeV2Checkpointsw
StaticRegexFullMatchStaticRegexFullMatchfile_prefix"/device:CPU:**
_output_shapes
: *
pattern
^s3://.*Z
ConstConst"/device:CPU:**
_output_shapes
: *
dtype0*
valueB B.parta
Const_1Const"/device:CPU:**
_output_shapes
: *
dtype0*
valueB B
_temp/part�
SelectSelectStaticRegexFullMatch:output:0Const:output:0Const_1:output:0"/device:CPU:**
T0*
_output_shapes
: f

StringJoin
StringJoinfile_prefixSelect:output:0"/device:CPU:**
N*
_output_shapes
: L

num_shardsConst*
_output_shapes
: *
dtype0*
value	B :f
ShardedFilename/shardConst"/device:CPU:0*
_output_shapes
: *
dtype0*
value	B : �
ShardedFilenameShardedFilenameStringJoin:output:0ShardedFilename/shard:output:0num_shards:output:0"/device:CPU:0*
_output_shapes
: �
SaveV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:*
dtype0*s
valuejBhBvar1/.ATTRIBUTES/VARIABLE_VALUEBvar2/.ATTRIBUTES/VARIABLE_VALUEB_CHECKPOINTABLE_OBJECT_GRAPHs
SaveV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:*
dtype0*
valueBB B B �
SaveV2SaveV2ShardedFilename:filename:0SaveV2/tensor_names:output:0 SaveV2/shape_and_slices:output:0savev2_var1_read_readvariableopsavev2_var2_read_readvariableopsavev2_const"/device:CPU:0*
_output_shapes
 *
dtypes
2�
&MergeV2Checkpoints/checkpoint_prefixesPackShardedFilename:filename:0^SaveV2"/device:CPU:0*
N*
T0*
_output_shapes
:�
MergeV2CheckpointsMergeV2Checkpoints/MergeV2Checkpoints/checkpoint_prefixes:output:0file_prefix"/device:CPU:0*
_output_shapes
 f
IdentityIdentityfile_prefix^MergeV2Checkpoints"/device:CPU:0*
T0*
_output_shapes
: Q

Identity_1IdentityIdentity:output:0^NoOp*
T0*
_output_shapes
: [
NoOpNoOp^MergeV2Checkpoints*"
_acd_function_control_output(*
_output_shapes
 "!

identity_1Identity_1:output:0*3
_input_shapes"
 : ::: 2(
MergeV2CheckpointsMergeV2Checkpoints:C ?

_output_shapes
: 
%
_user_specified_namefile_prefix:($
"
_output_shapes
::($
"
_output_shapes
::

_output_shapes
: 
�
�
__inference___call___49

input1

input21
mul_readvariableop_resource:3
mul_1_readvariableop_resource:
identity��mul/ReadVariableOp�mul_1/ReadVariableOpr
mul/ReadVariableOpReadVariableOpmul_readvariableop_resource*"
_output_shapes
:*
dtype0d
mulMulinput1mul/ReadVariableOp:value:0*
T0*+
_output_shapes
:���������v
mul_1/ReadVariableOpReadVariableOpmul_1_readvariableop_resource*"
_output_shapes
:*
dtype0h
mul_1Mulinput2mul_1/ReadVariableOp:value:0*
T0*+
_output_shapes
:���������V
addAddV2mul:z:0	mul_1:z:0*
T0*+
_output_shapes
:���������J
sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  4BY
subSubadd:z:0sub/y:output:0*
T0*+
_output_shapes
:���������Q
outputIdentitysub:z:0*
T0*+
_output_shapes
:���������b
IdentityIdentityoutput:output:0^NoOp*
T0*+
_output_shapes
:���������r
NoOpNoOp^mul/ReadVariableOp^mul_1/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*E
_input_shapes4
2:���������:���������: : 2(
mul/ReadVariableOpmul/ReadVariableOp2,
mul_1/ReadVariableOpmul_1/ReadVariableOp:S O
+
_output_shapes
:���������
 
_user_specified_nameinput1:SO
+
_output_shapes
:���������
 
_user_specified_nameinput2
�
�
__inference___call___22

input1

input21
mul_readvariableop_resource:3
mul_1_readvariableop_resource:
identity��mul/ReadVariableOp�mul_1/ReadVariableOpr
mul/ReadVariableOpReadVariableOpmul_readvariableop_resource*"
_output_shapes
:*
dtype0d
mulMulinput1mul/ReadVariableOp:value:0*
T0*+
_output_shapes
:���������v
mul_1/ReadVariableOpReadVariableOpmul_1_readvariableop_resource*"
_output_shapes
:*
dtype0h
mul_1Mulinput2mul_1/ReadVariableOp:value:0*
T0*+
_output_shapes
:���������V
addAddV2mul:z:0	mul_1:z:0*
T0*+
_output_shapes
:���������J
sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  4BY
subSubadd:z:0sub/y:output:0*
T0*+
_output_shapes
:���������Q
outputIdentitysub:z:0*
T0*+
_output_shapes
:���������b
IdentityIdentityoutput:output:0^NoOp*
T0*+
_output_shapes
:���������r
NoOpNoOp^mul/ReadVariableOp^mul_1/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*E
_input_shapes4
2:���������:���������: : 2(
mul/ReadVariableOpmul/ReadVariableOp2,
mul_1/ReadVariableOpmul_1/ReadVariableOp:S O
+
_output_shapes
:���������
 
_user_specified_nameinput1:SO
+
_output_shapes
:���������
 
_user_specified_nameinput2
�
�
 __inference_signature_wrapper_34

input1

input2
unknown:
	unknown_0:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinput1input2unknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:���������*$
_read_only_resource_inputs
*>
config_proto.,

CPU

GPU2*0,1,2,3,4,5,6,7J 8� * 
fR
__inference___call___22s
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*+
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*E
_input_shapes4
2:���������:���������: : 22
StatefulPartitionedCallStatefulPartitionedCall:S O
+
_output_shapes
:���������
 
_user_specified_nameinput1:SO
+
_output_shapes
:���������
 
_user_specified_nameinput2
�
�
__inference__traced_restore_95
file_prefix+
assignvariableop_var1:-
assignvariableop_1_var2:

identity_3��AssignVariableOp�AssignVariableOp_1�
RestoreV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:*
dtype0*s
valuejBhBvar1/.ATTRIBUTES/VARIABLE_VALUEBvar2/.ATTRIBUTES/VARIABLE_VALUEB_CHECKPOINTABLE_OBJECT_GRAPHv
RestoreV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:*
dtype0*
valueBB B B �
	RestoreV2	RestoreV2file_prefixRestoreV2/tensor_names:output:0#RestoreV2/shape_and_slices:output:0"/device:CPU:0* 
_output_shapes
:::*
dtypes
2[
IdentityIdentityRestoreV2:tensors:0"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOpAssignVariableOpassignvariableop_var1Identity:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_1IdentityRestoreV2:tensors:1"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_1AssignVariableOpassignvariableop_1_var2Identity_1:output:0"/device:CPU:0*
_output_shapes
 *
dtype01
NoOpNoOp"/device:CPU:0*
_output_shapes
 �

Identity_2Identityfile_prefix^AssignVariableOp^AssignVariableOp_1^NoOp"/device:CPU:0*
T0*
_output_shapes
: U

Identity_3IdentityIdentity_2:output:0^NoOp_1*
T0*
_output_shapes
: p
NoOp_1NoOp^AssignVariableOp^AssignVariableOp_1*"
_acd_function_control_output(*
_output_shapes
 "!

identity_3Identity_3:output:0*
_input_shapes
: : : 2$
AssignVariableOpAssignVariableOp2(
AssignVariableOp_1AssignVariableOp_1:C ?

_output_shapes
: 
%
_user_specified_namefile_prefix"�L
saver_filename:0StatefulPartitionedCall_1:0StatefulPartitionedCall_28"
saved_model_main_op

NoOp*>
__saved_model_init_op%#
__saved_model_init_op

NoOp*�
serving_default�
=
input13
serving_default_input1:0���������
=
input23
serving_default_input2:0���������@
output_04
StatefulPartitionedCall:0���������tensorflow/serving/predict:�	
P
var1
var2
__call__

signatures"
_generic_user_object
:2var1
:2var2
�
trace_02�
__inference___call___49�
���
FullArgSpec'
args�
jself
jinput1
jinput2
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 ztrace_0
,
serving_default"
signature_map
�B�
__inference___call___49input1input2"�
���
FullArgSpec'
args�
jself
jinput1
jinput2
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�B�
 __inference_signature_wrapper_34input1input2"�
���
FullArgSpec
args� 
varargs
 
varkwjkwargs
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 �
__inference___call___49}Y�V
O�L
$�!
input1���������
$�!
input2���������
� "�����������
 __inference_signature_wrapper_34�m�j
� 
c�`
.
input1$�!
input1���������
.
input2$�!
input2���������"7�4
2
output_0&�#
output_0���������