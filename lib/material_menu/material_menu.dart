// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/glyph/glyph.dart';
import 'package:angular_components/material_button/material_button.dart';
import 'package:angular_components/material_menu/menu_popup.dart';
import 'package:angular_components/material_menu/menu_popup_wrapper.dart';
import 'package:angular_components/material_popup/material_popup.dart';
import 'package:angular_components/material_tooltip/material_tooltip.dart';
import 'package:angular_components/model/menu/menu.dart';

/// The Material Menu renders a menu based on a [MenuModel] object. This menu
/// comprises a `material-list` in a `material-popup` and a
/// `material-button` whose text or icon can be specified by the caller.
///
/// The menu expands when the button is clicked and closes when either an item
/// is selected or a region outside the dropdown is clicked.
///
/// __Example usage:__
///
///     <material-menu [menu]="menuModel">
///     </material-menu>
@Component(
  selector: 'material-menu',
  directives: const [
    GlyphComponent,
    MaterialButtonComponent,
    MaterialTooltipDirective,
    MenuPopupComponent,
    NgIf,
    PopupSourceDirective
  ],
  templateUrl: 'material_menu.html',
  changeDetection: ChangeDetectionStrategy.OnPush,
  // TODO(google): Change preserveWhitespace to false to improve codesize.
  preserveWhitespace: true,
)
class MaterialMenuComponent extends Object with MenuPopupWrapper {
  final _onTrigger = new StreamController<Null>();

  /// Trigger button text. Ignored if the [MenuModel] has an icon.
  @Input()
  String buttonText;

  /// If true, the material menu will be closed if the trigger button is clicked
  /// while the menu is open.
  ///
  /// Otherwise, clicking the trigger button when the menu is already open will
  /// not do anything.
  @Input()
  bool closeMenuOnClick = false;

  @Input()
  bool disabled = false;

  /// Aria label for button trigger.
  @Input()
  String ariaLabel;

  /// Outputs an event when the menu button is triggered.
  @Output('trigger')
  Stream<Null> get onTrigger => _onTrigger.stream;

  String get tooltipText => menu?.tooltipText;

  bool get hasTooltip => menu?.hasTooltip ?? false;

  bool get hasSubmenu => menu?.itemGroups?.isNotEmpty ?? false;

  String get hasIcon => menu?.uiIcon != null ? 'true' : null;

  void handleButtonClick() {
    isExpanded = closeMenuOnClick ? !isExpanded : true;
    _onTrigger.add(null);
  }
}
