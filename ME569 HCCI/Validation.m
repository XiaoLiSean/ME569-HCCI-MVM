% Index  1      2       3       4       5       6
% States [m1_0  p2_0    m2_0]
% Output [W1c   m_c     W2c     p_ivc   T_ivc   m_f]
N           = 1000;
tau         = 120/N;
t_end       = time(end);

angle_end   = 180;
k           = angle_end / t_end;


subplot(2,3,1);
plot(k*time, 1000*states(:,1));hold on;
plot(k*time, 1000*states(:,3));
legend('m1 [g]', 'm2 [g]');
xlabel('Crank Angle ATDC [deg]');
ylabel('Manifold Gas Mass [g]')

subplot(2,3,2);
plot(k*time, 1e-3*states(:,2));
legend('p_2 [KPa]');
xlabel('Crank Angle ATDC [deg]');
ylabel('Manifold Pressure [KPa]')

subplot(2,3,3);
plot(k*time, 1000*output(:,1));hold on;
plot(k*time, 1000*output(:,3));
legend('W_{1c} [g/s]', 'W_{2c} [g/s]');
xlabel('Crank Angle ATDC [deg]');
ylabel('Cylinder Flow [g/s]')

subplot(2,3,4);
plot(k*time, 1e6*output(:,2));hold on;
plot(k*time, 1e6*output(:,6));
legend('m_c [mg]', 'm_f [mg]');
xlabel('Crank Angle ATDC [deg]');
ylabel('Mass [mg]')

subplot(2,3,5);
plot(k*time, 1e-3*output(:,4));
legend('p_{ivc} [KPa]');
xlabel('Crank Angle ATDC [deg]');
ylabel('Pressure at Intake Valve [KPa]')

subplot(2,3,6);
plot(k*time, output(:,5));
legend('T_{ivc} [K]');
xlabel('Crank Angle ATDC [deg]');
ylabel('Temperature at Intake Valve [KPa]')