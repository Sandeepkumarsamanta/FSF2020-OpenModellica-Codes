package N_Octane
  model ms
    extends Simulator.Streams.MaterialStream;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end ms;


  model react
    extends Simulator.UnitOperations.ConversionReactor;
    extends Simulator.Files.Models.ReactionManager.ConversionReaction;
  end react;


  model flowsheet
    extends Modelica.Icons.Example;
      parameter Integer Nc = 5;
      import data = Simulator.Files.ChemsepDatabase;
      parameter data.Ethylene eth;
      parameter data.Isobutane ibut;
      parameter data.Nbutane nbut;
      parameter data.Nitrogen nitro;
      parameter data.Noctane noct;
      parameter Simulator.Files.ChemsepDatabase.GeneralProperties C[Nc] = {eth, ibut, nbut, nitro, noct};
      N_Octane.ms recycle(Nc = Nc, C = C) annotation(
          Placement(visible = true, transformation(origin = {-418, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      N_Octane.ms S10(Nc = Nc, C = C) annotation(
          Placement(visible = true, transformation(origin = {-322, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      N_Octane.ms feed(Nc = Nc, C = C) annotation(
          Placement(visible = true, transformation(origin = {-230, 160}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      N_Octane.ms product(Nc = Nc, C = C) annotation(
          Placement(visible = true, transformation(origin = {-230, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Simulator.UnitOperations.Mixer mix1(Nc = Nc, C = C, NI = 2, outPress = "Inlet_Average") annotation(
          Placement(visible = true, transformation(origin = {-168, 144}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));  
      Simulator.Examples.Expander.AdiabExp B1(Nc = Nc, C = C, Eff = 0.75) annotation(
          Placement(visible = true, transformation(origin = {-368, 122}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Simulator.Streams.EnergyStream E1 annotation(
          Placement(visible = true, transformation(origin = {-390, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Simulator.Streams.EnergyStream E2 annotation(
          Placement(visible = true, transformation(origin = {-299, 41}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
      Simulator.UnitOperations.Heater B2(C = C, Eff = 1, Nc = Nc, Pdel = 0)  annotation(
          Placement(visible = true, transformation(origin = {-276, 120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));  
      N_Octane.ms reactorF(Nc = Nc, C = C) annotation(
          Placement(visible = true, transformation(origin = {-124, 86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      N_Octane.react react1(Nc = Nc, C = C, Pdel = 48263.2, Nr = 1, BC_r = {1}, Coef_cr = {{-2}, {-1}, {0}, {0}, {1}}, X_r = {0.98}, CalcMode = "Isothermal", Tdef = 366.15) annotation(
          Placement(visible = true, transformation(origin = {-88, 86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      N_Octane.ms S02(Nc = Nc, C = C) annotation(
          Placement(visible = true, transformation(origin = {-48, 86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Simulator.Streams.EnergyStream E3 annotation(
          Placement(visible = true, transformation(origin = {-110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      N_Octane.ms S03(Nc = Nc, C = C) annotation(
          Placement(visible = true, transformation(origin = {42, 102}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      N_Octane.ms S04(Nc = Nc, C = C) annotation(
          Placement(visible = true, transformation(origin = {42, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Simulator.UnitOperations.CompoundSeparator cs1(Nc = Nc, C = C, SepFact_c = {"Molar_Flow", "Molar_Flow", "Molar_Flow", "Molar_Flow", "Molar_Flow"}, SepStrm = 1) annotation(
          Placement(visible = true, transformation(origin = {-2, 86}, extent = {{-10, -20}, {10, 20}}, rotation = 0)));
  equation
    connect(cs1.Out2, S04.In) annotation(
      Line(points = {{8, 78}, {20, 78}, {20, 56}, {32, 56}, {32, 58}, {32, 58}}, color = {0, 70, 70}));
    connect(cs1.Out1, S03.In) annotation(
      Line(points = {{8, 94}, {18, 94}, {18, 102}, {32, 102}, {32, 102}, {32, 102}}, color = {0, 70, 70}));
    connect(S02.Out, cs1.In) annotation(
      Line(points = {{-38, 86}, {-12, 86}, {-12, 86}, {-12, 86}}, color = {0, 70, 70}));
    connect(B2.En, E2.Out) annotation(
      Line(points = {{-286, 110}, {-278, 110}, {-278, 40}, {-286, 40}, {-286, 42}}, color = {255, 0, 0}));
    connect(S10.Out, B2.In) annotation(
      Line(points = {{-312, 100}, {-298, 100}, {-298, 120}, {-286, 120}}, color = {0, 70, 70}));
    connect(B2.Out, product.In) annotation(
      Line(points = {{-266, 120}, {-252, 120}, {-252, 100}, {-240, 100}}, color = {0, 70, 70}));
    connect(E1.Out, B1.En) annotation(
      Line(points = {{-380, 40}, {-368, 40}, {-368, 115}}, color = {255, 0, 0}));
    connect(recycle.Out, B1.In) annotation(
      Line(points = {{-408, 100}, {-390, 100}, {-390, 122}, {-378, 122}}, color = {0, 70, 70}));
    connect(B1.Out, S10.In) annotation(
      Line(points = {{-358, 122}, {-342, 122}, {-342, 100}, {-332, 100}}, color = {0, 70, 70}));
    connect(reactorF.Out, react1.In) annotation(
      Line(points = {{-114, 86}, {-98, 86}, {-98, 86}, {-98, 86}}, color = {0, 70, 70}));
    connect(react1.Out, S02.In) annotation(
      Line(points = {{-78, 86}, {-58, 86}, {-58, 86}, {-58, 86}}, color = {0, 70, 70}));
    connect(E3.Out, react1.energy) annotation(
      Line(points = {{-100, 40}, {-90, 40}, {-90, 50}, {-80, 50}, {-80, 58}, {-90, 58}, {-90, 72}, {-88, 72}, {-88, 74}, {-88, 74}}, color = {255, 0, 0}));
    connect(mix1.Out, reactorF.In) annotation(
      Line(points = {{-158, 144}, {-146, 144}, {-146, 86}, {-134, 86}, {-134, 86}, {-134, 86}}, color = {0, 70, 70}));
    connect(product.Out, mix1.In[2]) annotation(
      Line(points = {{-220, 100}, {-198, 100}, {-198, 140}, {-178, 140}, {-178, 144}, {-178, 144}}, color = {0, 70, 70}));
    connect(feed.Out, mix1.In[1]) annotation(
      Line(points = {{-220, 160}, {-198, 160}, {-198, 144}, {-178, 144}, {-178, 144}, {-178, 144}}, color = {0, 70, 70}));
    recycle.x_pc[1, :] = {0.000000088, 0.001688, 0.0442, 0.00000020, 0.9541};
    recycle.P = 165476;
    recycle.T = 366.15;
    recycle.F_p[1] = 0.892734;
    B1.Pdel = 27581;
    product.T = 366.15;
    feed.x_pc[1, :] = {0.6536, 0.3268, 0.01634, 0.003268, 0};
    feed.P = 137896;
    feed.T = 366.15;
    feed.F_p[1] = 8.5;
    cs1.SepVal_c = {0.1131, 0.0187, 0.3813, 0.2617, 0.4824};
  end flowsheet;




























































































































  model AdiabExp
    extends Simulator.UnitOperations.AdiabaticExpander;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end AdiabExp;

  model fls
    extends Simulator.UnitOperations.Flash;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end fls;

  model Shortcut
    extends Simulator.UnitOperations.ShortcutColumn;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end Shortcut;

  model Condensor
    extends Simulator.UnitOperations.DistillationColumn.Cond;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end Condensor;


  model Tray
    extends Simulator.UnitOperations.DistillationColumn.DistTray;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end Tray;


  model Reboiler
    extends Simulator.UnitOperations.DistillationColumn.Reb;
    extends Simulator.Files.ThermodynamicPackages.RaoultsLaw;
  end Reboiler;


  model DisColumn
    extends Simulator.UnitOperations.DistillationColumn.DistCol;
    Condensor condenser(Nc = Nc, C = C, Ctype = Ctype, Bin = Bin_t[1]);
    Reboiler reboiler(Nc = Nc, C = C, Bin = Bin_t[Nt]);
    Tray tray[Nt - 2](each Nc = Nc, each C = C, Bin = Bin_t[2:Nt - 1]);
  end DisColumn;









end N_Octane;
