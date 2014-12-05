/*
 jQWidgets v3.6.0 (2014-Nov-25)
 Copyright (c) 2011-2014 jQWidgets.
 License: http://jqwidgets.com/license/
 */

if (!jqxBaseFramework) {
	var jqxBaseFramework = window.minQuery || window.jQuery
}
(function (h, q, i) {
	if (!q) {
		return
	}
	h.jqx = h.jqx || {};
	h.jqx.AMD = false;
	var b = q.module("jqwidgets", []);
	var u = q.module("jqwidgets-amd", [], function () {
		h.jqx.AMD = true
	});
	var f = null;
	var C = null;
	var v = null;
	var z = null;
	var s = null;
	var c = new Array();
	var D = new Array();
	var p = new Array();
	var r = new Array();
	var g = new Array();
	var d = new Array();
	var e = {};
	var x = false;
	var l = function () {
		var E = document.getElementsByTagName("script");
		var G, F, H;
		for (G = 0; F = E[G]; G++) {
			H = F.src;
			if (H.indexOf("jqxcore.js") >= 0) {
				var I = H.substring(0, H.indexOf("jqxcore.js"));
				break
			}
		}
		return I
	}();

	function y(I, J, E, G, F) {
		if (G && F) {
			switch (I) {
				case"jqxGrid":
				case"jqxDataTable":
				case"jqxTreeGrid":
					if (E.columns) {
						var L = G.columns || G;
						var H = F.columns || F;
						if (L.length != H.length) {
							return false
						}
						var K = {};
						h.each(L, function (M, O) {
							var N = this;
							for (var P in this) {
								if (N[P] != H[M][P]) {
									var Q = N.datafield || N.dataField;
									if (!K[Q]) {
										K[Q] = {}
									}
									K[Q][P] = N[P]
								}
							}
						});
						if (!h.isEmptyObject(K)) {
							h.each(K, function (N, P) {
								for (var O in P) {
									var M = h(J).jqxProxy("getcolumnproperty", N, O);
									if (M !== P[O]) {
										h(J).jqxProxy("setcolumnproperty", N, O, P[O])
									}
								}
							});
							return true
						}
					}
					break
			}
		}
		return false
	}

	function a(O, H, N, G, L, K) {
		var E = function (R) {
			if (K === "jqxTree" || K === "jqxMenu") {
				return R
			}
			if (typeof R == "object") {
				if (R._bindingUpdate != null) {
					return R
				}
			}
			var Q = {};
			if (h.isArray(R) || (R instanceof Object && !R.url && !(R.localdata || R.localData))) {
				Q.localData = R;
				Q.type = "array"
			} else {
				if (R.url) {
					Q = R
				} else {
					if (R.localdata || R.localData) {
						Q = R
					}
				}
			}
			var S = new h.jqx.dataAdapter(Q);
			return S
		};
		if (N.jqxSource != i) {
			O.$watchCollection(N.jqxSource, function (S, R) {
				if (S != R) {
					var Q = E(S);
					h(H).jqxProxy({source: Q})
				}
			})
		} else {
			var I = null;
			var M = f(N.jqxSettings)(O);
			var J = H.controller();
			for (var F in J) {
				if (J[F] == M.source) {
					I = F;
					break
				}
			}
			if (!I) {
				for (var F in O) {
					if (O[F] == M.source) {
						I = F;
						break
					}
				}
			}
			if (I) {
				var P = "";
				for (var F in O) {
					if (O[F] == J) {
						P = F;
						break
					}
				}
				if (P != "") {
					I = P + "." + I
				}
				L.$watchCollection(I, function (S, R) {
					if (S != R) {
						var Q = E(S);
						h(H).jqxProxy({source: Q})
					}
				})
			}
			O.$watchCollection(N.jqxSettings + ".source", function (S, R) {
				if (S != R) {
					var Q = E(S);
					h(H).jqxProxy({source: Q})
				}
			});
			O.$watchCollection(N.jqxSettings, function (S, R) {
				if (S.source != R.source) {
					if (S.source && R.source && h.isArray(S.source) && h.isArray(R.source)) {
						if (A(S.source) == A(R.source)) {
							return
						}
					}
					var Q = E(S.source);
					h(H).jqxProxy({source: Q})
				}
			})
		}
		return E(G)
	}

	function A(E) {
		if (E == null) {
			return""
		}
		var F = "";
		h.each(E, function (H) {
			var J = this;
			if (H > 0) {
				F += ", "
			}
			F += "[";
			var G = 0;
			if (h.type(J) == "object") {
				for (var I in J) {
					if (G > 0) {
						F += ", "
					}
					F += "{" + I + ":" + J[I] + "}";
					G++
				}
			} else {
				if (G > 0) {
					F += ", "
				}
				F += "{" + H + ":" + J + "}";
				G++
			}
			F += "]"
		});
		return F
	}

	function k(I, G, F, E, H, J) {
		h.extend(h.jqx["_" + E + ""].prototype, {definedInstance: function () {
			if (this.element !== G[0]) {
				return true
			}
			var K = this;
			h.each(J, function (N, O) {
				K.addHandler(h(G), N, function (P) {
					I.$parent ? h.proxy(O, H)(P) : O(P);
					if (I.$root.$$phase != "$apply" && I.$root.$$phase != "$digest") {
						I.$apply()
					}
				})
			});
			var L = F.$attr;
			h.each(F, function (Q, R) {
				if (Q.indexOf("jqxOn") >= 0) {
					var N = L[Q].substring(7);
					var P = h.camelCase(N);
					var O = R;
					K.addHandler(h(G), P, function (T) {
						T.data = F.data || F.jqxData;
						if (O.indexOf("(") >= 0) {
							var S = O.indexOf("(");
							var U = f(O.substring(0, S))(I);
							if (U) {
								U(T)
							} else {
								I.$emit(P, T)
							}
						} else {
							I.$emit(O, T)
						}
						if (I.$root.$$phase != "$apply" && I.$root.$$phase != "$digest") {
							I.$apply()
						}
					})
				}
			});
			if (F.jqxInstance) {
				var M = f(F.jqxInstance).assign;
				if (M) {
					M(I, K)
				}
				if (I.$root.$$phase != "$apply" && I.$root.$$phase != "$digest") {
					I.$apply()
				}
			}
		}})
	}

	function j(J, H, F, E, I, K) {
		if (F.jqxSettings) {
			var G = f(F.jqxSettings)(J);
			if (!G.apply) {
				G.apply = G[E] = function () {
					var L = arguments;
					var M = new Array();
					if (L.length == 0) {
						return true
					}
					h.each(D[I.$id + E], function (N, O) {
						var P = this;
						M.push({widgetName: E, element: P, result: h.jqx.jqxWidgetProxy(E, P, L)})
					});
					if (M.length == 1) {
						return M[0].result
					}
					return M
				};
				G.refresh = function (P, O) {
					var M = {};
					var L = h(H)[E]("getInstance");
					h.each(G, function (Q, S) {
						if (Q === "created" || Q == "data" || Q == "refresh" || Q == E ||
								Q == "apply") {
							return true
						}
						var R = L.events || L._events;
						if ((R && R.indexOf(Q) >= 0) ||
								Q.match(/(mousedown|click|mouseenter|mouseleave|mouseup|keydown|keyup|focus|blur|keypress)/g)) {
							return true
						}
						if (P != i && P.indexOf(Q) === -1) {
							return true
						}
						M[Q] = S
					});
					if (M !== {}) {
						if (O) {
							h.each(M, function (Q, R) {
								G[Q] = L[Q]
							});
							if (J.$root.$$phase != "$apply" && J.$root.$$phase != "$digest") {
								J.$apply()
							}
						} else {
							h.each(D[I.$id + E], function (Q, R) {
								h(this).jqxProxy(M)
							});
							if (F.jqxWatchSettings != i) {
								if (I) {
									var N = f(F.jqxSettings)(I);
									h.each(N, function (Q, U) {
										if (Q.match(/(source|created|data|apply|refresh)/g)) {
											return true
										}
										var S = L.events || L._events;
										if ((S && S.indexOf(Q) >= 0) ||
												Q.match(/(mousedown|click|mouseenter|mouseleave|mouseup|keydown|keyup|focus|blur|keypress)/g)) {
											return true
										}
										if (Q === E) {
											return true
										}
										if (!p[F.jqxSettings + "." + Q]) {
											var T = Q;
											var R = I.$watch(F.jqxSettings + "." + Q,
													function (X, W) {
														if (X != W) {
															var V = {};
															V[T] = X;
															h.each(D[I.$id + E], function (Z, aa) {
																var Y = y(E, h(this), V, X, W);
																if (!Y) {
																	h(this).jqxProxy(V)
																}
															})
														}
													}, true);
											p[F.jqxSettings + "." + Q] = R
										}
									})
								}
							}
						}
					}
					if (e[E]) {
						M = {};
						h.each(e[E], function () {
							if (P != i && P.indexOf(h.camelCase(this.value.substring(4))) === -1) {
								return true
							}
							M[h.camelCase(this.value.substring(4))] = J.$eval(this.label);
							if (O) {
								var Q = h.parse(this.label)(J).assign;
								if (Q) {
									Q(J, L[h.camelCase(this.value.substring(4))])
								}
							}
						});
						if (!O) {
							h.each(D[I.$id + E], function (Q, R) {
								h(this).jqxProxy(M)
							})
						} else {
							if (J.$root.$$phase != "$apply" && J.$root.$$phase != "$digest") {
								J.$apply()
							}
						}
					}
				};
				D[I.$id + E] = new Array();
				D[I.$id + E].push(K)
			} else {
				if (!D[I.$id + E]) {
					D[I.$id + E] = new Array()
				}
				D[I.$id + E].push(K)
			}
		}
	}

	function m(M, I, L, F, J, H) {
		var K = /(jqxGrid|jqxTree|jqxMenu|jqxDataTable|jqxTreeGrid|jqxListBox|jqxTreeMap|jqxComboBox|jqxDropDownList|jqxChart)/ig;
		if (H && H.source === i && L.jqxSource === i && F.match(K)) {
			if (F.match(/(jqxTree|jqxMenu)/ig)) {
				if (I[0].innerHTML.toLowerCase().indexOf("ul") === -1) {
					H.source = []
				}
			} else {
				H.source = []
			}
		}
		if (H.source !== i) {
			H.source = a(M, I, L, H.source, J, F)
		} else {
			if (L.jqxSource !== i) {
				var E = q.extend({}, M.$eval(L.jqxSource));
				var G = L.jqxSource && L.jqxSource.dataBind ? true : false;
				if (G) {
					H.source = a(M, I, L, L.jqxSource, J, F)
				} else {
					H.source = a(M, I, L, E, J, F)
				}
			}
		}
		M.$watch(L.ngDisabled, function (P, O) {
			if (P != i) {
				if (P != O || h(I).jqxProxy("disabled") !== P) {
					var N = {};
					N.disabled = P;
					h(I).jqxProxy(N)
				}
			}
		})
	}

	function n(O, I, N, E, M) {
		var G = q.extend({}, O.$eval(N.jqxSettings));
		m(O, I, N, E, M, G);
		var K = {};
		var J = {};
		if (e[E]) {
			h.each(e[E], function () {
				var S = this.label;
				var T = this.value;
				var R = h.camelCase(T.substring("4"));
				if (typeof N[S] !== "undefined") {
					var U = O.$eval(N[S]);
					if (R == "instance") {
						return true
					}
					if (h.type(U) === "array" && E !== "source") {
						U = U.slice(0)
					} else {
						if (h.type(U) === "object" && E !== "source") {
							U = h.extend({}, U)
						}
					}
					K[R] = U;
					var Q = function (Z, X) {
						if (Z != X) {
							var Y = h.camelCase(T.substring("4"));
							if (Y == "watch") {
								if (N.jqxWatch.indexOf(",") >= 0 || N.jqxWatch.indexOf("[") >= 0) {
									var ab = N.jqxWatch;
									ab = ab.replace("[", "");
									ab = ab.replace("]", "");
									ab = ab.trim();
									ab = ab.split(",");
									h.each(ab, function (ae, ag) {
										var ah = this.split(".");
										for (var af = 0; af < ah.length; af++) {
											if (ah[af] in h(I).data().jqxWidget) {
												Y = ah[af];
												break
											} else {
												if (ah[af].toLowerCase() in h(I).data().jqxWidget) {
													Y = ah[af].toLowerCase();
													break
												}
											}
										}
										var ac = {};
										ac[Y] = Z[ae];
										var ad = y(E, h(I), ac, Z, X);
										if (!ad) {
											h(I).jqxProxy(ac)
										}
									});
									return
								}
								var ab = N.jqxWatch.split(".");
								for (var aa = 0; aa < ab.length; aa++) {
									if (ab[aa] in h(I).data().jqxWidget) {
										Y = ab[aa];
										break
									} else {
										if (ab[aa].toLowerCase() in h(I).data().jqxWidget) {
											Y = ab[aa].toLowerCase();
											break
										}
									}
								}
							}
							var V = {};
							V[Y] = Z;
							var W = y(E, h(I), V, Z, X);
							if (!W) {
								h(I).jqxProxy(V)
							}
						}
					};
					if (R == "watch") {
						delete K[R];
						O.$watch(N[S], Q, true)
					} else {
						O.$watch(N[S], Q)
					}
				}
			})
		}
		if (I[0].id == "") {
			if (i == c[E]) {
				c[E] = 0
			}
			I[0].id = E + c[E]++
		}
		var F = h(I)[E];
		if (!F) {
			throw new Error("Missing required JavaScript references for: " + E);
			return null
		}
		h.each(G, function (R, S) {
			if (R === "data" || R === "created") {
				return true
			}
			var Q = /(dragStart|dragEnd|createCommand|ready|render|initrowdetails|initTabContent|initContent|renderer|renderToolbar|renderStatusBar|groupsrenderer|pagerrenderer|groupcolumnrenderer|updatefilterconditions|handlekeyboardnavigation|updatefilterpanel|rendered|virtualModeCreateRecords|virtualModeRecordCreating|search|selectionRenderer)/ig;
			if (h.isFunction(S) && !R.match(Q)) {
				J[R] = S
			} else {
				if (R.match(Q)) {
					var T = function () {
						var U = S.apply(this, arguments);
						if (O.$root.$$phase != "$apply" && O.$root.$$phase != "$digest") {
							O.$apply()
						}
						return U
					};
					K[R] = T;
					return true
				}
				if (h.type(S) === "array" && R !== "source") {
					S = S.slice(0)
				} else {
					if (h.type(S) === "object" && R !== "source") {
						S = h.extend({}, S)
					}
				}
				K[R] = S
			}
		});
		k(O, I, N, E, M, J);
		var L = I[0];
		j(O, I, N, E, M, L);
		var H = h(I)[E](K);
		var P = h(I)[E]("getInstance");
		B(O, I, N, E, M, G, L, P, K);
		O.$on("$destroy", function () {
			if (P && P.destroy) {
				h(I)[E]("destroy")
			} else {
				h(I).remove()
			}
		});
		return P
	}

	function B(M, G, L, E, J, F, I, N, H) {
		if (L.jqxSettings) {
			if (L.jqxWatchSettings != i) {
				if (J) {
					var K = f(L.jqxSettings)(J);
					h.each(K, function (O, S) {
						if (O.match(/(source|created|data|apply|refresh)/g)) {
							return true
						}
						var Q = N.events || N._events;
						if ((Q && Q.indexOf(O) >= 0) ||
								O.match(/(mousedown|click|mouseenter|mouseleave|mouseup|keydown|keyup|focus|blur|keypress)/g)) {
							return true
						}
						if (O === E) {
							return true
						}
						if (H.hasOwnProperty(O)) {
							var R = O;
							var P = J.$watch(L.jqxSettings + "." + O, function (W, V) {
								if (W != V) {
									var T = {};
									T[R] = W;
									var U = y(E, h(G), T, W, V);
									if (!U) {
										h(G).jqxProxy(T)
									}
								}
							}, true);
							p[L.jqxSettings + "." + O] = P
						}
					})
				}
			}
			M.$watch(L.jqxSettings, function (S, R) {
				var P = {};
				var O = false;
				if (S != R) {
					h.each(S, function (U, X) {
						if (U === "source") {
							if (R.source != null) {
								return true
							} else {
								var T = a(M, G, L, X, J);
								P[U] = T
							}
						}
						if (U === "created") {
							return true
						}
						if (U === "data") {
							M.$apply();
							return true
						}
						var V = N.events || N._events;
						if ((V && V.indexOf(U) >= 0) ||
								U.match(/(mousedown|click|mouseenter|mouseleave|mouseup|keydown|keyup|focus|blur|keypress)/g)) {
							return true
						}
						var W = function (Z) {
							if (L.jqxWatchSettings != i) {
								if (J) {
									if (!p[L.jqxSettings + "." + Z]) {
										var Z = U;
										var Y = J.$watch(L.jqxSettings + "." + Z,
												function (ad, ac) {
													if (ad != ac) {
														var aa = {};
														aa[Z] = ad;
														var ab = y(E, h(G), aa, ad, ac);
														if (!ab) {
															h(G).jqxProxy(aa)
														}
													}
												}, true);
										p[L.jqxSettings + "." + Z] = Y
									}
								}
							}
						};
						if (!(X instanceof Object) && (R == null || X !== R[U])) {
							P[U] = X;
							W(U);
							O = true
						} else {
							if (U !== E && U !== "apply" && U !== "created" &&
									(X instanceof Object) &&
									(R == null || (A(X) !== A(R[U])) ||
											(A(X) == "" && A(R[U]) == ""))) {
								P[U] = X;
								W(U);
								O = true
							}
						}
					});
					if (P !== {} && O) {
						var Q = y(E, h(G), P, S, R);
						if (!Q) {
							h(G).jqxProxy(P)
						}
					}
				}
			})
		}
	}

	function w(H) {
		var L = H[0].nodeName.toLowerCase();
		var M = h(H).parent();
		var F = h(H).html();
		var J = '<div id="jqx-ngwidget">' + F + "</div>";
		if (L.indexOf("jqx") >= 0) {
			var G = H[0].attributes;
			var K = H;
			if (L.indexOf("input") >= 0) {
				if (L.indexOf("date") >= 0 || L.indexOf("number") >= 0) {
					h(H).replaceWith('<div id="jqx-ngwidget"></div>')
				} else {
					if (L.indexOf("password") >= 0) {
						h(H).replaceWith('<input id="jqx-ngwidget" type="password"/>')
					} else {
						h(H).replaceWith('<input id="jqx-ngwidget"/>')
					}
				}
			} else {
				if (L.indexOf("jqx-button") >= 0 && L.indexOf("jqx-button-group") == -1) {
					h(H).replaceWith('<button id="jqx-ngwidget">' + F + "</button>")
				} else {
					if (L.indexOf("jqx-toggle-button") >= 0) {
						h(H).replaceWith('<button id="jqx-ngwidget">' + F + "</button>")
					} else {
						if (L.indexOf("jqx-link-button") >= 0) {
							if (h(H).find("a").length > 0) {
								var I = h(H).find("a");
								I.attr("id", "jqx-ngwidget");
								h(H).replaceWith(I)
							} else {
								h(H).replaceWith('<a id="jqx-ngwidget">' + F + "</a>")
							}
						} else {
							if (L.indexOf("jqx-data-table") >= 0) {
								if (h(H).find("tr").length > 0) {
									h(H).replaceWith('<div id="jqx-ngwidget">' + F + "</div>")
								} else {
									h(H).replaceWith('<div id="jqx-ngwidget"></div>')
								}
							} else {
								if (L.indexOf("jqx-list-box") >= 0 ||
										L.indexOf("jqx-drop-down-list") >= 0 ||
										L.indexOf("jqx-combo-box") >= 0) {
									if (h(H).find("option").length > 0) {
										h(H).replaceWith('<select id="jqx-ngwidget">' + F +
												"</select>")
									} else {
										if (h(H).find("li").length > 0) {
											h(H).replaceWith('<ul id="jqx-ngwidget">' + F + "</ul>")
										} else {
											h(H).replaceWith('<div id="jqx-ngwidget"></div>')
										}
									}
								} else {
									if (L.indexOf("jqx-list-menu") >= 0) {
										h(H).replaceWith('<ul id="jqx-ngwidget" data-role="listmenu">' +
												F + "</ul>")
									} else {
										if (L.indexOf("jqx-tooltip") >= 0) {
											var E = h(H).children();
											E.detach();
											h(E).insertAfter(h(H));
											h.each(G, function () {
												if (h(E)[0]) {
													h(E)[0].setAttribute(this.name, this.value)
												}
											});
											h(H).remove()
										} else {
											h(H).replaceWith(J)
										}
									}
								}
							}
						}
					}
				}
			}
			K = M.find("#jqx-ngwidget").removeAttr("id");
			h.each(G, function () {
				if (h(K)[0]) {
					h(K)[0].setAttribute(this.name, this.value)
				}
			})
		}
	}

	function t(G, H) {
		function F(L) {
			H.filesCount = 0;
			var I = L.length;
			if (L.scripts) {
				var K = L.scripts.length;
				for (var N in L.deps) {
					K++;
					var M = L.deps[N];
					K += M.length
				}
				I = K
			}
			var J = function (S, P) {
				var R = 0;
				var O = 0;
				var Q = function () {
					var Y = S[R];
					var T = h('script[src*="' + Y + '"]').length;
					if (T === 0) {
						var V = document.getElementsByTagName("head")[0];
						var U = document.createElement("script");
						U.type = "text/javascript";
						var X = function () {
							H.filesCount++;
							O++;
							g[Y] = false;
							if (r[Y] != i) {
								h.each(r[Y], function () {
									this.documentReady = true;
									if (this.scriptsLoaded) {
										this.scriptsLoaded()
									}
								})
							}
							r[Y] = true;
							if (H.filesCount == I) {
								H.documentReady = true;
								if (H.scriptsLoaded) {
									H.scriptsLoaded()
								}
								return
							}
							if (O === S.length && P) {
								P()
							}
						};
						if (U.addEventListener) {
							U.addEventListener("load", X, false)
						} else {
							if (window.attachEvent) {
								U.attachEvent("onreadystatechange", function () {
									if (U.readyState == "complete" || U.readyState == "loaded") {
										X()
									}
								})
							}
						}
						g[Y] = true;
						var W = l;
						if (Y == "globalize.js") {
							W = l + "globalization/"
						}
						U.src = W + Y;
						V.appendChild(U);
						R++;
						if (R < S.length) {
							Q()
						}
					} else {
						H.filesCount++;
						if (H.filesCount == I) {
							if (r[Y] === true || g[Y] === i) {
								H.documentReady = true;
								if (H.scriptsLoaded) {
									H.scriptsLoaded()
								}
								return
							} else {
								if (r[Y] == i) {
									r[Y] = new Array()
								}
								r[Y].push(H);
								return
							}
						}
						R++;
						if (R < S.length) {
							Q()
						}
						O++;
						if (O === S.length && P) {
							P()
						}
					}
				};
				Q()
			};
			if (!L.scripts) {
				J(L)
			} else {
				J(L.scripts);
				h.each(L.deps, function (Q, P) {
					var O = new Array();
					O.push(Q);
					J(O, function () {
						J(P)
					})
				})
			}
		}

		var E = {jqxCalendar: [
			"jqxdatetimeinput.js", "jqxcalendar.js", "jqxtooltip.js",
			"globalize.js", "jqxbuttons.js"
		], jqxDateTimeInput: [
			"jqxdatetimeinput.js", "jqxcalendar.js", "jqxtooltip.js",
			"globalize.js", "jqxbuttons.js"
		], jqxListBox: [
			"jqxlistbox.js", "jqxdata.js", "jqxbuttons.js", "jqxscrollbar.js"
		], jqxComboBox: [
			"jqxlistbox.js", "jqxdata.js", "jqxbuttons.js", "jqxscrollbar.js",
			"jqxcombobox.js"
		], jqxDropDownList: [
			"jqxlistbox.js", "jqxdata.js", "jqxbuttons.js", "jqxscrollbar.js",
			"jqxdropdownlist.js"
		], jqxGrid: {scripts: [
			"jqxdatetimeinput.js", "jqxcalendar.js", "jqxmenu.js",
			"jqxtooltip.js", "jqxscrollbar.js", "jqxbuttons.js", "jqxlistbox.js",
			"jqxdropdownlist.js", "jqxcombobox.js", "jqxcheckbox.js", "globalize.js"
		], deps: {"jqxgrid.js": [
			"jqxgrid.selection.js", "jqxgrid.filter.js", "jqxgrid.sort.js",
			"jqxgrid.storage.js", "jqxgrid.grouping.js", "jqxgrid.pager.js",
			"jqxgrid.columnsresize.js", "jqxgrid.columnsreorder.js", "jqxgrid.edit.js",
			"jqxgrid.export.js", "jqxgrid.aggregates.js"
		], "jqxdata.js": ["jqxdata.export.js"]}}, jqxDataTable: {scripts: [
			"jqxdatetimeinput.js",
			"jqxcalendar.js", "jqxmenu.js", "jqxtooltip.js", "jqxscrollbar.js", "jqxbuttons.js",
			"jqxlistbox.js", "jqxdropdownlist.js", "jqxcombobox.js", "jqxcheckbox.js",
			"globalize.js", "jqxinput.js"
		], deps: {"jqxdatatable.js": ["jqxtreegrid.js"], "jqxdata.js": [
			"jqxdata.export.js"
		]}}, jqxTreeGrid: {scripts: [
			"jqxdatetimeinput.js", "jqxcalendar.js", "jqxmenu.js",
			"jqxtooltip.js", "jqxscrollbar.js", "jqxbuttons.js", "jqxlistbox.js",
			"jqxdropdownlist.js", "jqxcombobox.js", "jqxcheckbox.js", "globalize.js", "jqxinput.js"
		], deps: {"jqxdatatable.js": ["jqxtreegrid.js"], "jqxdata.js": [
			"jqxdata.export.js"
		]}}, jqxCheckBox: ["jqxcheckbox.js"], jqxRadioButton: ["jqxradiobutton.js"], jqxBulletChart:
				["jqxbulletchart.js", "jqxtooltip.js"], jqxRangeSelector: [
			"jqxrangeselector.js"
		], jqxScrollView: ["jqxbuttons.js", "jqxscrollview.js"], jqxSwitchButton: [
			"jqxswitchbutton.js"
		], jqxTouch: ["jqxtouch.js"], jqxColorPicker: ["jqxcolorpicker.js"], jqxInput: [
			"jqxinput.js"
		], jqxEditor: ["jqxeditor.js"], jqxNumberInput: [
			"jqxbuttons.js", "jqxnumberinput.js"
		], jqxMaskedInput: ["jqxmaskedinput.js"], jqxSlider: [
			"jqxbuttons.js", "jqxslider.js"
		], jqxPanel: ["jqxbuttons.js", "jqxscrollbar.js", "jqxpanel.js"], jqxButton: [
			"jqxbuttons.js"
		], jqxLinkButton: ["jqxbuttons.js"], jqxToggleButton: ["jqxbuttons.js"], jqxRepeatButton: [
			"jqxbuttons.js"
		], jqxDropDownButton: ["jqxdropdownbutton.js"], jqxNotification: [
			"jqxnotification.js"
		], jqxDockPanel: ["jqxdockpanel.js"], jqxProgressBar: ["jqxprogressbar.js"], jqxListMenu: [
			"jqxbuttons.js", "jqxscrollbar.js", "jqxpanel.js", "jqxlistmenu.js"
		], jqxTree: [
			"jqxbuttons.js", "jqxscrollbar.js", "jqxpanel.js", "jqxtree.js", "jqxdata.js"
		], jqxMenu: ["jqxmenu.js", "jqxdata.js"], jqxTabs: [
			"jqxtabs.js", "jqxbuttons.js"
		], jqxDragDrop: ["jqxdragdrop.js"], jqxDraw: ["jqxdraw.js"], jqxWindow: [
			"jqxwindow.js"
		], jqxDocking: ["jqxwindow.js", "jqxdocking.js"], jqxButtonGroup: [
			"jqxbuttons.js",
			"jqxbuttongroup.js"
		], jqxChart: ["jqxdata.js", "jqxchart.js"], jqxNavigationBar: [
			"jqxnavigationbar.js"
		], jqxExpander: ["jqxexpander.js"], jqxResponse: ["jqxresponse.js"], jqxPasswordInput: [
			"jqxpasswordinput.js"
		], jqxRating: ["jqxrating.js"], jqxSplitter: [
			"jqxbuttons.js", "jqxsplitter.js"
		], jqxValidator: ["jqxvalidator.js"], jqxTooltip: ["jqxtooltip.js"], jqxGauge: [
			"jqxdraw.js", "jqxgauge.js"
		], jqxTreeMap: ["jqxtreemap.js"], jqxRibbon: [
			"jqxbuttons.js", "jqxribbon.js"
		], jqxFormattedInput: ["jqxbuttons.js", "jqxformattedinput.js"], jqxNavBar: [
			"jqxnavbar.js"
		]};
		F(E[G])
	}

	function o(E) {
		var F = {};
		var G = function (Q, K, P, J, H) {
			if (h.jqx.AMD) {
				var M = {};
				d[E] = false;
				M.documentReady = false;
				t(E, M)
			}
			var I = K[0].style.visibility;
			var L = K[0].style.display;
			K[0].style.visibility = "hidden";
			K[0].style.display = "none";
			var O = Q;
			var N = v(function () {
				v.cancel(N);
				N = i;
				var U = function () {
					var aa = J[0];
					K[0].style.visibility = I;
					K[0].style.display = L;
					var Z = n(Q, K, P, E, O);
					var W = E.toLowerCase();
					var Y = E.match(/(input|list|radio|checkbox|combobox|rating|slider|scrollbar|progress|range|editor|picker|range|gauge|calendar|switch|button)/ig);
					var X = {element: K[0], name: E, instance: h(K).data().jqxWidget, id: K[0].id, scope: Q};
					Q.$emit(E + "Created", X);
					if (P.jqxSettings && f(P.jqxSettings)(Q).created) {
						C(function () {
							var ac = f(P.jqxSettings)(Q).created;
							ac(X)
						})
					}
					if (P.jqxCreated) {
						C(function () {
							var ac = f(P.jqxCreated)(Q);
							ac(X)
						})
					}
					C(function ab() {
						if (aa) {
							aa.$render = function () {
								var ae = aa.$viewValue;
								if (ae === i) {
									ae = aa.$modelValue
								}
								if (E === "jqxRadioButton") {
									if (Q.$eval(h(K).attr("value")) == aa.$viewValue) {
										h(K).val(true)
									} else {
										if (Q.$eval(h(K).attr("value")) == "true" &&
												aa.$viewValue == true) {
											h(K).val(true)
										} else {
											h(K).val(false)
										}
									}
									return
								} else {
									if (E === "jqxCheckBox") {
										if (Q.$eval(h(K).attr("ng-true-value")) == aa.$viewValue) {
											h(K).val(true)
										}
										if (Q.$eval(h(K).attr("ng-false-value")) == aa.$viewValue) {
											h(K).val(false)
										} else {
											h(K).val(aa.$viewValue)
										}
										return
									}
								}
								if (ae != h(K).val()) {
									C(function () {
										h(K).val(ae)
									})
								}
							};
							if (Y) {
								var ad = "keyup change";
								if (E == "jqxScrollBar") {
									ad = "valueChanged"
								}
								if (E == "jqxToggleButton") {
									ad = "keyup click"
								}
								if (E == "jqxInput") {
									ad = "keyup change select"
								}
								h(K).on(ad, function (af) {
									var ae = af.args;
									C(function () {
										if (E === "jqxRadioButton") {
											if (ae.type != "api") {
												aa.$setViewValue(Q.$eval(h(K).attr("value")))
											}
										} else {
											if (E === "jqxCheckBox") {
												if (h(K).attr("ng-true-value") != i && ae.checked) {
													aa.$setViewValue(h(K).attr("ng-true-value"))
												} else {
													if (h(K).attr("ng-false-value") != i &&
															!ae.checked) {
														aa.$setViewValue(h(K).attr("ng-false-value"))
													} else {
														aa.$setViewValue(h(K).val())
													}
												}
											} else {
												if (E === "jqxDropDownList" ||
														E === "jqxComboBox" || E === "jqxListBox" ||
														E === "jqxInput") {
													var ah = h(K).val();
													if (P.jqxNgModel != i) {
														var ag = h(K).data().jqxWidget;
														if (ag.getSelectedItem) {
															ah = ag.getSelectedItem();
															if (ah.originalItem) {
																ah = ah.originalItem
															}
														}
														if (E === "jqxInput") {
															ah = ag.selectedItem
														}
														aa.$setViewValue(ah)
													} else {
														aa.$setViewValue(ah)
													}
												} else {
													if (E === "jqxDateTimeInput" ||
															E === "jqxCalendar") {
														if (P.jqxNgModel != i) {
															var ag = h(K).data().jqxWidget;
															if (ag.selectionMode == "range") {
																aa.$setViewValue(ag.getRange())
															} else {
																aa.$setViewValue(ag.getDate())
															}
														} else {
															aa.$setViewValue(h(K).val())
														}
													} else {
														if (E == "jqxToggleButton") {
															var ag = h(K).data().jqxWidget;
															aa.$setViewValue(ag.toggled)
														} else {
															aa.$setViewValue(h(K).val())
														}
													}
												}
											}
										}
										Q.$emit(E + "ModelChange", aa.$viewValue)
									})
								})
							}
							if (E === "jqxRadioButton") {
								if (Q.$eval(h(K).attr("value")) == aa.$viewValue) {
									h(K).val(true)
								} else {
									if (Q.$eval(h(K).attr("value")) == "true" &&
											aa.$viewValue == true) {
										h(K).val(true)
									} else {
										h(K).val(false)
									}
								}
							} else {
								if (E === "jqxCheckBox") {
									if (Q.$eval(h(K).attr("ng-true-value")) == aa.$viewValue) {
										h(K).val(true)
									}
									if (Q.$eval(h(K).attr("ng-false-value")) == aa.$viewValue) {
										h(K).val(false)
									} else {
										h(K).val(aa.$viewValue)
									}
								} else {
									if (E === "jqxDropDownList" || E === "jqxComboBox" ||
											E === "jqxListBox" || E === "jqxInput") {
										if (P.jqxNgModel != i) {
											var ac = h(K).data().jqxWidget;
											if (E != "jqxInput") {
												if (ac.valueMember) {
													ac.selectItem(aa.$viewValue[ac.valueMember])
												} else {
													if (ac.displayMember) {
														ac.selectItem(aa.$viewValue[ac.displayMember])
													} else {
														h(K).val(aa.$viewValue)
													}
												}
											} else {
												h(K).val(aa.$viewValue)
											}
										} else {
											h(K).val(aa.$viewValue)
										}
									} else {
										if (E === "jqxDateTimeInput" || E === "jqxCalendar") {
											if (P.jqxNgModel != i) {
												var ac = h(K).data().jqxWidget;
												if (ac.selectionMode == "range") {
													ac.setRange(aa.$viewValue)
												} else {
													ac.setDate(aa.$viewValue)
												}
											} else {
												h(K).val(aa.$viewValue)
											}
										} else {
											if (E == "jqxToggleButton") {
												var ac = h(K).data().jqxWidget;
												ac.toggled = true;
												ac.refresh()
											} else {
												h(K).val(aa.$viewValue)
											}
										}
									}
								}
							}
						}
					})
				};
				if (P.ngShow !== i && P.jqxCreate === i) {
					var T = Q.$watch(P.ngShow, function (X, W) {
						if (X) {
							U();
							T()
						}
					});
					return
				}
				var V = function () {
					if (P.jqxCreate != null || P.jqxCreate != null) {
						if (P.jqxCreate === true ||
								(P.jqxCreate !== null && h.type(P.jqxCreate) == "object")) {
							U()
						} else {
							var W = Q.$watch(P.jqxCreate, function (Y, X) {
								if (typeof Y == "number") {
									C(U, Y);
									W()
								} else {
									if (Y) {
										U();
										W()
									}
								}
							})
						}
					} else {
						U()
					}
				};
				if (h.jqx.AMD) {
					var S = function () {
						var W = true;
						for (var X in d) {
							if (!d[X]) {
								W = false;
								break
							}
						}
						if (W) {
							if (!x) {
								Q.$emit("jQWidgetsScriptsLoaded");
								x = true
							}
							for (var X in d) {
								h.each(d[X], function () {
									this()
								});
								d[X] = new Array()
							}
						}
					};
					if (M.documentReady) {
						var R = {element: K[0], name: E, scope: Q};
						Q.$emit(E + "ScriptsLoaded", R);
						if (!d[E]) {
							d[E] = new Array()
						}
						d[E].push(V);
						S()
					} else {
						M.scriptsLoaded = function () {
							var W = {element: K[0], name: E, scope: Q};
							Q.$emit(E + "ScriptsLoaded", W);
							if (!d[E]) {
								d[E] = new Array()
							}
							d[E].push(V);
							S()
						}
					}
				} else {
					V()
				}
			})
		};
		b.directive(E,
				[
					"$timeout", "$interval", "$parse", "$compile", "$log",
					function (M, I, N, L, K) {
						C = M;
						v = I;
						f = N;
						z = L;
						s = K;
						var J = {};
						var H;
						return{restrict: "ACE", require: [
							"?ngModel"
						], scope: false, template: function (P, O) {
							w(P);
							var Q = this;
							h.each(O, function (R, S) {
								if (R !== E && R != "jqxNgModel" && R.indexOf("jqxOn") == -1 &&
										R != "jqxData" && R != "jqxWatchSettings" &&
										R != "jqxCreated" && R != "jqxSource" && R != "jqxCreate" &&
										R != "jqxSettings" && R.indexOf("jqx") >= 0) {
									if (!e[E]) {
										e[E] = new Array()
									}
									e[E].push({label: R, value: O.$attr[R]})
								}
							});
							H = this.scope
						}, controller: [
							"$scope", "$attrs", "$element", "$transclude",
							function (R, O, Q, P) {
							}
						], compile: function (P, O, Q) {
							return{pre: function (V, T, R, U, S) {
							}, post: function (V, T, R, U, S) {
								G(V, T, R, U, S)
							}}
						}, link: G}
					}
				])
	}

	o("jqxBulletChart");
	o("jqxButtonGroup");
	o("jqxButton");
	o("jqxRepeatButton");
	o("jqxToggleButton");
	o("jqxLinkButton");
	o("jqxCalendar");
	o("jqxChart");
	o("jqxCheckBox");
	o("jqxColorPicker");
	o("jqxComboBox");
	o("jqxDataTable");
	o("jqxDateTimeInput");
	o("jqxDocking");
	o("jqxDockPanel");
	o("jqxDragDrop");
	o("jqxDraw");
	o("jqxDropDownButton");
	o("jqxDropDownList");
	o("jqxEditor");
	o("jqxExpander");
	o("jqxFormattedInput");
	o("jqxGauge");
	o("jqxGrid");
	o("jqxInput");
	o("jqxListBox");
	o("jqxListMenu");
	o("jqxMaskedInput");
	o("jqxMenu");
	o("jqxNavigationBar");
	o("jqxNavBar");
	o("jqxNotification");
	o("jqxNumberInput");
	o("jqxPanel");
	o("jqxPasswordInput");
	o("jqxProgressBar");
	o("jqxRadioButton");
	o("jqxRangeSelector");
	o("jqxRating");
	o("jqxRibbon");
	o("jqxScrollBar");
	o("jqxScrollView");
	o("jqxSlider");
	o("jqxSplitter");
	o("jqxSwitchButton");
	o("jqxTabs");
	o("jqxTooltip");
	o("jqxTouch");
	o("jqxTree");
	o("jqxTreeGrid");
	o("jqxTreeMap");
	o("jqxValidator");
	o("jqxWindow")
})(jqxBaseFramework, window.angular);
