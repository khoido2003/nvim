-- ============================================================
-- Unity + Godot 4 C# Method Snippets
-- for LuaSnip (Neovim)
--
-- INSTALL:
--   Place at: ~/.config/nvim/snippets/cs.lua
--   Or require it from your luasnip config:
--     require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets" })
--
-- USAGE:
--   Type the trigger (e.g. `_Ready`, `OnCollisionEnter`) then
--   press your snippet expand key (Tab / <C-k> etc.)
--   Cursor lands inside the method body.
--
-- TRIGGERS:
--   Unity  → PascalCase  (OnCollisionEnter, Awake, FixedUpdate …)
--   Godot  → _PascalCase (_Ready, _Process, _PhysicsProcess …)
-- ============================================================

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- Helper: builds a simple method snippet
--   trig      : completion trigger word
--   sig       : full method signature line
--   desc      : shown in cmp popup
--   is_override : if true, prepends "public override " (Godot style)
local function m(trig, sig, desc)
	return s({ trig = trig, name = sig, dscr = desc }, { t({ sig, "{", "\t" }), i(1), t({ "", "}" }) })
end

-- ============================================================
--  ██╗   ██╗███╗   ██╗██╗████████╗██╗   ██╗
--  ██║   ██║████╗  ██║██║╚══██╔══╝╚██╗ ██╔╝
--  ██║   ██║██╔██╗ ██║██║   ██║    ╚████╔╝
--  ██║   ██║██║╚██╗██║██║   ██║     ╚██╔╝
--  ╚██████╔╝██║ ╚████║██║   ██║      ██║
--   ╚═════╝ ╚═╝  ╚═══╝╚═╝   ╚═╝      ╚═╝
-- ============================================================

ls.add_snippets("cs", {

	-- ──────────────────────────────────────────
	-- UNITY › Core Lifecycle
	-- ──────────────────────────────────────────

	m("Awake", "private void Awake()", "[Unity] Called when the script instance is first loaded"),

	m("OnEnable", "private void OnEnable()", "[Unity] Called when the object becomes enabled and active"),

	m("Start", "private void Start()", "[Unity] Called before the first frame update"),

	m("Update", "private void Update()", "[Unity] Called every frame"),

	m("LateUpdate", "private void LateUpdate()", "[Unity] Called every frame, after all Update calls"),

	m("FixedUpdate", "private void FixedUpdate()", "[Unity] Called every fixed physics timestep"),

	m("OnDisable", "private void OnDisable()", "[Unity] Called when the object becomes disabled or inactive"),

	m("OnDestroy", "private void OnDestroy()", "[Unity] Called when the MonoBehaviour is destroyed"),

	m("OnApplicationQuit", "private void OnApplicationQuit()", "[Unity] Called before the application quits"),

	m(
		"OnApplicationPause",
		"private void OnApplicationPause(bool pauseStatus)",
		"[Unity] Called when the app pauses or resumes"
	),

	m(
		"OnApplicationFocus",
		"private void OnApplicationFocus(bool hasFocus)",
		"[Unity] Called when the app gains or loses focus"
	),

	-- ──────────────────────────────────────────
	-- UNITY › Physics 3D – Collision
	-- ──────────────────────────────────────────

	m("OnCollisionEnter", "private void OnCollisionEnter(Collision collision)", "[Unity] 3D collision begins"),

	m(
		"OnCollisionStay",
		"private void OnCollisionStay(Collision collision)",
		"[Unity] 3D collision continues each frame"
	),

	m("OnCollisionExit", "private void OnCollisionExit(Collision collision)", "[Unity] 3D collision ends"),

	-- ──────────────────────────────────────────
	-- UNITY › Physics 2D – Collision
	-- ──────────────────────────────────────────

	m("OnCollisionEnter2D", "private void OnCollisionEnter2D(Collision2D collision)", "[Unity] 2D collision begins"),

	m(
		"OnCollisionStay2D",
		"private void OnCollisionStay2D(Collision2D collision)",
		"[Unity] 2D collision continues each frame"
	),

	m("OnCollisionExit2D", "private void OnCollisionExit2D(Collision2D collision)", "[Unity] 2D collision ends"),

	-- ──────────────────────────────────────────
	-- UNITY › Physics 3D – Trigger
	-- ──────────────────────────────────────────

	m("OnTriggerEnter", "private void OnTriggerEnter(Collider other)", "[Unity] A collider enters the 3D trigger"),

	m("OnTriggerStay", "private void OnTriggerStay(Collider other)", "[Unity] A collider stays inside the 3D trigger"),

	m("OnTriggerExit", "private void OnTriggerExit(Collider other)", "[Unity] A collider exits the 3D trigger"),

	-- ──────────────────────────────────────────
	-- UNITY › Physics 2D – Trigger
	-- ──────────────────────────────────────────

	m(
		"OnTriggerEnter2D",
		"private void OnTriggerEnter2D(Collider2D other)",
		"[Unity] A Collider2D enters the 2D trigger"
	),

	m(
		"OnTriggerStay2D",
		"private void OnTriggerStay2D(Collider2D other)",
		"[Unity] A Collider2D stays inside the 2D trigger"
	),

	m("OnTriggerExit2D", "private void OnTriggerExit2D(Collider2D other)", "[Unity] A Collider2D exits the 2D trigger"),

	-- ──────────────────────────────────────────
	-- UNITY › Rendering
	-- ──────────────────────────────────────────

	m("OnBecameVisible", "private void OnBecameVisible()", "[Unity] Renderer becomes visible by any camera"),

	m("OnBecameInvisible", "private void OnBecameInvisible()", "[Unity] Renderer is no longer visible by any camera"),

	m("OnPreRender", "private void OnPreRender()", "[Unity] Called before the camera renders the scene"),

	m("OnPostRender", "private void OnPostRender()", "[Unity] Called after the camera finishes rendering"),

	m(
		"OnRenderImage",
		"private void OnRenderImage(RenderTexture source, RenderTexture destination)",
		"[Unity] Post-processing hook after scene rendering"
	),

	m("OnRenderObject", "private void OnRenderObject()", "[Unity] Called after the camera renders the scene"),

	m("OnWillRenderObject", "private void OnWillRenderObject()", "[Unity] Called per-camera when object is visible"),

	m("OnDrawGizmos", "private void OnDrawGizmos()", "[Unity] Draw gizmos that are always visible in Scene view"),

	m(
		"OnDrawGizmosSelected",
		"private void OnDrawGizmosSelected()",
		"[Unity] Draw gizmos only when the object is selected"
	),

	-- ──────────────────────────────────────────
	-- UNITY › Mouse Input (legacy)
	-- ──────────────────────────────────────────

	m("OnMouseDown", "private void OnMouseDown()", "[Unity] Mouse button pressed over this collider"),

	m("OnMouseUp", "private void OnMouseUp()", "[Unity] Mouse button released"),

	m(
		"OnMouseUpAsButton",
		"private void OnMouseUpAsButton()",
		"[Unity] Mouse released over same collider it was pressed on"
	),

	m("OnMouseEnter", "private void OnMouseEnter()", "[Unity] Mouse cursor enters this collider"),

	m("OnMouseOver", "private void OnMouseOver()", "[Unity] Mouse cursor hovers over this collider each frame"),

	m("OnMouseExit", "private void OnMouseExit()", "[Unity] Mouse cursor exits this collider"),

	m("OnMouseDrag", "private void OnMouseDrag()", "[Unity] Mouse drag over this collider"),

	-- ──────────────────────────────────────────
	-- UNITY › Animation
	-- ──────────────────────────────────────────

	m("OnAnimatorMove", "private void OnAnimatorMove()", "[Unity] Process root motion from the Animator"),

	m("OnAnimatorIK", "private void OnAnimatorIK(int layerIndex)", "[Unity] Set up IK on the given layer"),

	-- ──────────────────────────────────────────
	-- UNITY › Joints
	-- ──────────────────────────────────────────

	m("OnJointBreak", "private void OnJointBreak(float breakForce)", "[Unity] A joint on this object broke"),

	m("OnJointBreak2D", "private void OnJointBreak2D(Joint2D brokenJoint)", "[Unity] A Joint2D on this object broke"),

	-- ──────────────────────────────────────────
	-- UNITY › Particles
	-- ──────────────────────────────────────────

	m(
		"OnParticleCollision",
		"private void OnParticleCollision(GameObject other)",
		"[Unity] A particle from this system hit a collider"
	),

	m(
		"OnParticleTrigger",
		"private void OnParticleTrigger()",
		"[Unity] Particles in this system met trigger conditions"
	),

	m(
		"OnParticleSystemStopped",
		"private void OnParticleSystemStopped()",
		"[Unity] The Particle System stopped playing"
	),

	-- ──────────────────────────────────────────
	-- UNITY › Audio
	-- ──────────────────────────────────────────

	m(
		"OnAudioFilterRead",
		"private void OnAudioFilterRead(float[] data, int channels)",
		"[Unity] Audio system reads audio data for DSP"
	),

	-- ──────────────────────────────────────────
	-- UNITY › Transform / Hierarchy
	-- ──────────────────────────────────────────

	m(
		"OnTransformChildrenChanged",
		"private void OnTransformChildrenChanged()",
		"[Unity] The list of children of this transform changed"
	),

	m(
		"OnTransformParentChanged",
		"private void OnTransformParentChanged()",
		"[Unity] The parent of this transform changed"
	),

	-- ──────────────────────────────────────────
	-- UNITY › Editor / Validation
	-- ──────────────────────────────────────────

	m("OnValidate", "private void OnValidate()", "[Unity] Called in editor when script loads or a value changes"),

	m("Reset", "private void Reset()", "[Unity] Reset to default values (Editor only)"),

	m("OnGUI", "private void OnGUI()", "[Unity] Render and handle Legacy GUI events"),

	-- ──────────────────────────────────────────
	-- UNITY › ScriptableObject / Serialization
	-- ──────────────────────────────────────────

	m(
		"OnAfterDeserialize",
		"public void OnAfterDeserialize()",
		"[Unity] Called after the object is deserialized (ISerializationCallbackReceiver)"
	),

	m(
		"OnBeforeSerialize",
		"public void OnBeforeSerialize()",
		"[Unity] Called before the object is serialized (ISerializationCallbackReceiver)"
	),

	-- ============================================================
	--   ██████╗  ██████╗ ██████╗  ██████╗ ████████╗
	--  ██╔════╝ ██╔═══██╗██╔══██╗██╔═══██╗╚══██╔══╝
	--  ██║  ███╗██║   ██║██║  ██║██║   ██║   ██║
	--  ██║   ██║██║   ██║██║  ██║██║   ██║   ██║
	--  ╚██████╔╝╚██████╔╝██████╔╝╚██████╔╝   ██║
	--   ╚═════╝  ╚═════╝ ╚═════╝  ╚═════╝    ╚═╝
	--  Godot 4 – C# virtual method overrides
	--  All use `public override` as required by the engine.
	-- ============================================================

	-- ──────────────────────────────────────────
	-- GODOT › Node – Core Lifecycle
	-- ──────────────────────────────────────────

	m(
		"_EnterTree",
		"public override void _EnterTree()",
		"[Godot] Called when node enters the SceneTree (may fire multiple times)"
	),

	m("_Ready", "public override void _Ready()", "[Godot] Called once when node and all children are in the SceneTree"),

	m("_ExitTree", "public override void _ExitTree()", "[Godot] Called when node is about to leave the SceneTree"),

	-- ──────────────────────────────────────────
	-- GODOT › Node – Per-Frame Processing
	-- ──────────────────────────────────────────

	m("_Process", "public override void _Process(double delta)", "[Godot] Called every frame (idle processing)"),

	m(
		"_PhysicsProcess",
		"public override void _PhysicsProcess(double delta)",
		"[Godot] Called every physics frame (fixed timestep)"
	),

	-- ──────────────────────────────────────────
	-- GODOT › Node – Input
	-- ──────────────────────────────────────────

	m(
		"_Input",
		"public override void _Input(InputEvent @event)",
		"[Godot] Called for every input event before _UnhandledInput"
	),

	m(
		"_UnhandledInput",
		"public override void _UnhandledInput(InputEvent @event)",
		"[Godot] Called for input events not consumed by _Input or GUI"
	),

	m(
		"_UnhandledKeyInput",
		"public override void _UnhandledKeyInput(InputEvent @event)",
		"[Godot] Called for key events not consumed by _Input or GUI"
	),

	m(
		"_ShortcutInput",
		"public override void _ShortcutInput(InputEvent @event)",
		"[Godot] Called for shortcut input events (between _Input and _UnhandledInput)"
	),

	-- ──────────────────────────────────────────
	-- GODOT › Node – Notifications & Config
	-- ──────────────────────────────────────────

	m(
		"_Notification",
		"public override void _Notification(int what)",
		"[Godot] Low-level notification callback (NOTIFICATION_* constants)"
	),

	m(
		"_GetConfigurationWarnings",
		"public override string[] _GetConfigurationWarnings()",
		"[Godot] Return warning strings shown in the editor Scene dock"
	),

	-- ──────────────────────────────────────────
	-- GODOT › Node2D / CanvasItem – Drawing
	-- ──────────────────────────────────────────

	m(
		"_Draw",
		"public override void _Draw()",
		"[Godot] Custom drawing commands for CanvasItem/Node2D (use Draw* methods inside)"
	),

	-- ──────────────────────────────────────────
	-- GODOT › Control (UI) – Input & Sizing
	-- ──────────────────────────────────────────

	m(
		"_GuiInput",
		"public override void _GuiInput(InputEvent @event)",
		"[Godot] Input events filtered for this Control (position, focus, z-order)"
	),

	m(
		"_GetMinimumSize",
		"public override Vector2 _GetMinimumSize()",
		"[Godot] Return the minimum size for this Control node"
	),

	m(
		"_MakeCustomTooltip",
		"public override Control _MakeCustomTooltip(string forText)",
		"[Godot] Return a custom tooltip Control for this node"
	),

	-- ──────────────────────────────────────────
	-- GODOT › RigidBody2D / RigidBody3D
	-- ──────────────────────────────────────────

	m(
		"_IntegrateForces", -- 2D
		"public override void _IntegrateForces(PhysicsDirectBodyState2D state)",
		"[Godot] Custom physics integration for RigidBody2D"
	),

	m(
		"_IntegrateForces3D", -- 3D  (same trigger prefix is distinct enough)
		"public override void _IntegrateForces(PhysicsDirectBodyState3D state)",
		"[Godot] Custom physics integration for RigidBody3D"
	),

	-- ──────────────────────────────────────────
	-- GODOT › CollisionObject2D / 3D – Input
	-- ──────────────────────────────────────────

	m(
		"_InputEvent",
		"public override void _InputEvent(Camera3D camera, InputEvent @event, Vector3 position, Vector3 normal, int shapeIdx)",
		"[Godot] Input on a CollisionObject3D (Area3D/StaticBody3D etc.)"
	),

	m(
		"_InputEvent2D",
		"public override void _InputEvent(Viewport viewport, InputEvent @event, int shapeIdx)",
		"[Godot] Input on a CollisionObject2D (Area2D/StaticBody2D etc.)"
	),

	m("_MouseEnter", "public override void _MouseEnter()", "[Godot] Mouse cursor enters this CollisionObject"),

	m("_MouseExit", "public override void _MouseExit()", "[Godot] Mouse cursor exits this CollisionObject"),

	m(
		"_MouseEnter2D",
		"public override void _MouseEnter()",
		"[Godot] Mouse enters CollisionObject2D (same signature, 2D context)"
	),

	m("_MouseExit2D", "public override void _MouseExit()", "[Godot] Mouse exits CollisionObject2D"),

	m(
		"_MouseShapeEnter",
		"public override void _MouseShapeEnter(int shapeIdx)",
		"[Godot] Mouse enters a specific collision shape"
	),

	m(
		"_MouseShapeExit",
		"public override void _MouseShapeExit(int shapeIdx)",
		"[Godot] Mouse exits a specific collision shape"
	),

	-- ──────────────────────────────────────────
	-- GODOT › AnimationTree / AnimationPlayer
	-- ──────────────────────────────────────────

	m(
		"_AnimationStarted",
		"public override void _AnimationStarted(StringName animName)",
		"[Godot] Called when an animation starts (AnimationMixer)"
	),

	m(
		"_AnimationFinished",
		"public override void _AnimationFinished(StringName animName)",
		"[Godot] Called when an animation finishes (AnimationMixer)"
	),

	-- ──────────────────────────────────────────
	-- GODOT › GDExtension / Object – Advanced
	-- ──────────────────────────────────────────

	m(
		"_Get",
		"public override Variant _Get(StringName property)",
		"[Godot] Override property getter (GodotObject._Get)"
	),

	m(
		"_Set",
		"public override bool _Set(StringName property, Variant value)",
		"[Godot] Override property setter (GodotObject._Set)"
	),

	m(
		"_GetPropertyList",
		"public override Godot.Collections.Array<Godot.Collections.Dictionary> _GetPropertyList()",
		"[Godot] Return dynamic property list for this object"
	),

	m(
		"_PropertyCanRevert",
		"public override bool _PropertyCanRevert(StringName property)",
		"[Godot] Return true if the property can be reverted to its default"
	),

	m(
		"_PropertyGetRevert",
		"public override Variant _PropertyGetRevert(StringName property)",
		"[Godot] Return the revert value for the given property"
	),

	m("_ToString", "public override string _ToString()", "[Godot] Custom string representation of this object"),
}, { key = "unity_godot" })
