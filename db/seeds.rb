if Rails.env.development?
  store1 = FactoryBot.create(:store)
  store2 = FactoryBot.create(:store)
  store3 = FactoryBot.create(:store)

  FactoryBot.create(:user, email: 'admin@email.com',
                           password: 'admin-password',
                           role: 'admin')

  FactoryBot.create(:user, email: 'employee@email.com',
                           password: 'employee-password',
                           role: 'employee',
                           store_id: store1.id)

  visitor1 = FactoryBot.create(:visitor, store: store1)
  visitor2 = FactoryBot.create(:visitor, store: store2)
  visitor3 = FactoryBot.create(:visitor, store: store3)

  Appointment.create(
    [
      { visitor_id: visitor1.id, store_id: store1.id, kind: 'check_in', event_time: Time.current - 15.days },
      { visitor_id: visitor1.id, store_id: store1.id, kind: 'check_out', event_time: Time.current - 15.days + 10.hours },
      { visitor_id: visitor1.id, store_id: store1.id, kind: 'check_in', event_time: Time.current - 12.days },
      { visitor_id: visitor1.id, store_id: store1.id, kind: 'check_out', event_time: Time.current - 12.days + 10.hours },
      { visitor_id: visitor2.id, store_id: store2.id, kind: 'check_in', event_time: Time.current - 10.days },
      { visitor_id: visitor2.id, store_id: store2.id, kind: 'check_out', event_time: Time.current - 10.days + 10.hours },
      { visitor_id: visitor2.id, store_id: store2.id, kind: 'check_in', event_time: Time.current - 9.days },
      { visitor_id: visitor2.id, store_id: store2.id, kind: 'check_out', event_time: Time.current - 9.days + 10.hours },
      { visitor_id: visitor3.id, store_id: store3.id, kind: 'check_in', event_time: Time.current - 7.days },
      { visitor_id: visitor3.id, store_id: store3.id, kind: 'check_out', event_time: Time.current - 7.days + 10.hours },
      { visitor_id: visitor3.id, store_id: store3.id, kind: 'check_in', event_time: Time.current - 5.days },
      { visitor_id: visitor3.id, store_id: store3.id, kind: 'check_out', event_time: Time.current - 5.days + 10.hours }
    ]
  )
end
